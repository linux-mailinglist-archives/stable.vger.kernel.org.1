Return-Path: <stable+bounces-174643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E580B3644C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBC9563A75
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422633EAF2;
	Tue, 26 Aug 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dN5cn0WW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440C335BC3;
	Tue, 26 Aug 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214934; cv=none; b=JZEpHDSqMkl+jyyJPc9U2c6vBx6jbtIyQkkqmDtdizfddm4be+laL1kpQzMKlZdOr8EROda45D+2ct03wG2MOEn0Ge8UzcRMslwjNEC8TxyqAAJZQkM6vQTX8o35QFRidwpjUPqeJSGT0lWlR0DHq+3yEIR3eArdH1JAr7/W+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214934; c=relaxed/simple;
	bh=2ECSQVdP+4MSYgYEVuVY65Y8/e9jHKIEqvOa9blXnEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP689gC+V0SAnGUh7M4PvS1mIVxNrrH8Rk8jmF4IXpZokyRHMOqQVU+GXRJMZ9TgJ9CCjoYbIXcVn7X9K228pOPot7i/WJt1Q3MowuZCVVCZDaXUenTmPdbePN2aX5kFHD/g4LcPUi7KLV/0GkqD9KK1a+TeDJsS/AKhNYO0o2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dN5cn0WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B0EC4CEF1;
	Tue, 26 Aug 2025 13:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214932;
	bh=2ECSQVdP+4MSYgYEVuVY65Y8/e9jHKIEqvOa9blXnEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dN5cn0WWBZMOtVbqOp3jX3TuJqvwg8uUyAasTi6OpyE75tKmbdyGtKX1GisekSUu4
	 qm6x8k72fShQtAS7lEUto6M4AjrR1Agfa+5Rfp+GXP786ihDrk6yRysCoTGDDJFnGf
	 N3sSmBaLcYt07LCDfZSatKrBju41yeFWrR8vcu2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John David Anglin <dave.anglin@bell.net>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 317/482] parisc: Try to fixup kernel exception in bad_area_nosemaphore path of do_page_fault()
Date: Tue, 26 Aug 2025 13:09:30 +0200
Message-ID: <20250826110938.638216327@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John David Anglin <dave.anglin@bell.net>

commit f92a5e36b0c45cd12ac0d1bc44680c0dfae34543 upstream.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/mm/fault.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -358,6 +358,10 @@ bad_area:
 	mmap_read_unlock(mm);
 
 bad_area_nosemaphore:
+	if (!user_mode(regs) && fixup_exception(regs)) {
+		return;
+	}
+
 	if (user_mode(regs)) {
 		int signo, si_code;
 



