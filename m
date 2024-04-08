Return-Path: <stable+bounces-36848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DE089C213
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA2EB2AEE0
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485D7D3E6;
	Mon,  8 Apr 2024 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bAcCDOlG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A3763F1;
	Mon,  8 Apr 2024 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582518; cv=none; b=L9ifkvMeEMuqOA1vODMmDvc8sYEK7UtIUidFmsCOzu0+Qhrfy1b1QGqjMOUWFHx8CipQqa4WOOpNvzA/gmuQgfhlUqQtLOyN39wyYjmIP0Nd7/6rjFLkTpRIBA78vnNoI9TK9yiLyaokbwB+eKh4MEMc/ZzgX221BM3vB9keKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582518; c=relaxed/simple;
	bh=ZX/3hfjkvNS5BcR3N17+7zKhrCfE5BcoqEddllsqSlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYECM0vl9TNszF/Bv3QSCQFqWmPbi062PA182TEvRnxJ2MMwQAFR6/b8MyDaXUQtsIHYbEFKTOVE+WSm+PrJKBfxpQFVOivn93QYwbWWJSlsD8qIHINy1HWimLg1bpisySPdIxrIkjQh3rGR0mTYkyWftmenI+luLmOEbGIOPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bAcCDOlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0681C433F1;
	Mon,  8 Apr 2024 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582518;
	bh=ZX/3hfjkvNS5BcR3N17+7zKhrCfE5BcoqEddllsqSlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAcCDOlG9tacMb4izKBHgQp5J0dQ5tof1ar76cUBoK981HHHU/03LDrPj8pqtq2t+
	 2mHz2Sgn50+iFKnpSq1UmlCHwOonf6GtS75VrA7umB1tpMLuzQWSfVDN9LP13iWiZq
	 hsjdF0KOnivIb+MwFdyPbee37U4xH0Wiz1JceX6o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.6 099/252] vboxsf: Avoid an spurious warning if load_nls_xxx() fails
Date: Mon,  8 Apr 2024 14:56:38 +0200
Message-ID: <20240408125309.721680299@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit de3f64b738af57e2732b91a0774facc675b75b54 upstream.

If an load_nls_xxx() function fails a few lines above, the 'sbi->bdi_id' is
still 0.
So, in the error handling path, we will call ida_simple_remove(..., 0)
which is not allocated yet.

In order to prevent a spurious "ida_free called for id=0 which is not
allocated." message, tweak the error handling path and add a new label.

Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/vboxsf/super.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -151,7 +151,7 @@ static int vboxsf_fill_super(struct supe
 		if (!sbi->nls) {
 			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
 			err = -EINVAL;
-			goto fail_free;
+			goto fail_destroy_idr;
 		}
 	}
 
@@ -224,6 +224,7 @@ fail_free:
 		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
+fail_destroy_idr:
 	idr_destroy(&sbi->ino_idr);
 	kfree(sbi);
 	return err;



