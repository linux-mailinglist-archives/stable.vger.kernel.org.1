Return-Path: <stable+bounces-91062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFCA9BEC40
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371581C239B7
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096FD1F472B;
	Wed,  6 Nov 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dYpPyiN9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3561DFD9D;
	Wed,  6 Nov 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897627; cv=none; b=UhGKr1n0qaWKXgzQE+OeVKuyoRn9QmL6w42RtE9H9i+r1UI7u916lB70GAMUSikJCHPbgunXcEXKV6I2Qhd74q8g+/6iBl6qsVrA0hX/J/S1DO0dvYvccRHPFEsBUbcKpYjak07wRWRsB0i56Lv6kntaaW2qsMkIVA5t7YnSAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897627; c=relaxed/simple;
	bh=I2qdmVh5xwsd3/o9M04NFsEcXaSZ3oiszivz7QTScJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYFwrdTNbKJ9+pCxpDu7THJX/XO+lmW3/snAN0isdn9TmO+d2SADPMJAW5fWnlCm5xAE2mEVOwlu339h1ahzB/uu/Xwg01jHvx67OXI7mLSRQRRpC3YL4CRQgxkxbXQyRRopg2xg/PcmJjzR7jvAsZUFaHtQsJqSJ20ZQLesfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dYpPyiN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE9AC4CECD;
	Wed,  6 Nov 2024 12:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897627;
	bh=I2qdmVh5xwsd3/o9M04NFsEcXaSZ3oiszivz7QTScJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYpPyiN9fJuEd75xjT/cx5omJHz3AGPYkRAber9HLim7fmn5KGbIiTfiYdbZ4J0yw
	 fSXlkqgbPxz3yi6yU4ndc8GwglWqRkLPVDxln80Ja+yE+sisI/okH5R/kSmiOKfv+c
	 +LPLhj2Y+rf93CY0y6pddAFaWzB6oxg5kTEGAsow=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongren Zheng <i@zenithal.me>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH 6.6 081/151] usbip: tools: Fix detach_port() invalid port error path
Date: Wed,  6 Nov 2024 13:04:29 +0100
Message-ID: <20241106120311.087106136@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

commit e7cd4b811c9e019f5acbce85699c622b30194c24 upstream.

The detach_port() doesn't return error
when detach is attempted on an invalid port.

Fixes: 40ecdeb1a187 ("usbip: usbip_detach: fix to check for invalid ports")
Cc: stable@vger.kernel.org
Reviewed-by: Hongren Zheng <i@zenithal.me>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
Link: https://lore.kernel.org/r/20241024022700.1236660-1-min_halo@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/usb/usbip/src/usbip_detach.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/usb/usbip/src/usbip_detach.c
+++ b/tools/usb/usbip/src/usbip_detach.c
@@ -68,6 +68,7 @@ static int detach_port(char *port)
 	}
 
 	if (!found) {
+		ret = -1;
 		err("Invalid port %s > maxports %d",
 			port, vhci_driver->nports);
 		goto call_driver_close;



