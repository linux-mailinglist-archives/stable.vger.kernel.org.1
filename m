Return-Path: <stable+bounces-101746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE8C9EEE6B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4672F16AC59
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F72054F8;
	Thu, 12 Dec 2024 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1unjEFYx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1D14A82;
	Thu, 12 Dec 2024 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018654; cv=none; b=IgVYkHdTeMIivk3vMBlbRlq9MCugoFqbHgy1jmKXroKhTiPdzi4sfT/M0yYwb4HITeEjkp8iozo8RveV0g0kq2JMckEKuhT/RuYnozYdMF13ogaz7vSBGP3Ocd5DW6OIT2mG8Lmi9BPiP8TkNo0sWWbHrZgWV/HNvyjaW+tv3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018654; c=relaxed/simple;
	bh=fEM603LFdQim31LD5HgpURtBskgkdfL/PM6PApeQtjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhzdXiBi1YsrQ2YFLAmT/uhNhMMk86VflBAurL+exeQHAqrGvArjrkKGZf2wWdzKwLvjNuvE7/EPnBNgQ7o7nmvQlYVB7OVKnOjbNrBrWrDbUUFLpZNxIaYzDqP3YP2lwKiDqk/LdvrT4MM758VocRiWle7kInFG6H/Tpm4g5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1unjEFYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB524C4CECE;
	Thu, 12 Dec 2024 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018654;
	bh=fEM603LFdQim31LD5HgpURtBskgkdfL/PM6PApeQtjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1unjEFYx+BvTcVo9peCevbTsEzufSCdoQFPe7S+b0nx5uQ1aIynCttYgLv+nyylWL
	 eWspn17dORKOKFbtlZQhO+CrkeXClGU7bRXsh1Rjj80bsHY1Bts6kjSi4eM+Dhax7E
	 XLDJAIpLoj2Lh0qqrNm+uxQo37hbFx8J1pb6WHFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.6 351/356] usb: dwc3: ep0: Dont reset resource alloc flag
Date: Thu, 12 Dec 2024 16:01:10 +0100
Message-ID: <20241212144258.443114940@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit f2e0eee4703869dc5edb5302a919861566ca7797 upstream.

The DWC3_EP_RESOURCE_ALLOCATED flag ensures that the resource of an
endpoint is only assigned once. Unless the endpoint is reset, don't
clear this flag. Otherwise we may set endpoint resource again, which
prevents the driver from initiate transfer after handling a STALL or
endpoint halt to the control endpoint.

Cc: stable@vger.kernel.org
Fixes: b311048c174d ("usb: dwc3: gadget: Rewrite endpoint allocation flow")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/00122b7cc5be06abef461776e7cc9f5ebc8bc1cb.1713229786.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/ep0.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -226,7 +226,8 @@ void dwc3_ep0_stall_and_restart(struct d
 
 	/* reinitialize physical ep1 */
 	dep = dwc->eps[1];
-	dep->flags = DWC3_EP_ENABLED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags |= DWC3_EP_ENABLED;
 
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];



