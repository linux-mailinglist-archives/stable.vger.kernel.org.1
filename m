Return-Path: <stable+bounces-180180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8C3B7EAC2
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A287AD07D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22711E7C2D;
	Wed, 17 Sep 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Doeg9OFh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E13161BB;
	Wed, 17 Sep 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113633; cv=none; b=F5pKrYsAzvhTIwRU9JdYZRQ+Mn/sUVHFmHEHGE4SUdAn5mjQ1ScUYNq9pKDWSw47BaTcx4HeSRFxQ7o+CnnV84Zt6E5UmW03visyk8TwLE6GCMZTlv5+76GJAqaG5C6yfR+gQv+Gz05TYEyfyAx+35pZQ6Z/jjwZmV0xW2b+JSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113633; c=relaxed/simple;
	bh=mk/OacGMi18J0H06QVApt2uqor3QtFRpoGD81kzpw3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLiXhvATR2cd73GAU1nsATZ5sa0VBLoeXgGpfdgMDP5y5KncWMACRsXixmGuPPjrBso9TkcXi8LIQlBwo2kWLmj92jQU9D/cOlJ8PbQ2xYs1tFk2c07cELyoFPSm1AyWLzun960Ixkw5i9K1c19M99V/sHOka4b0s0/S5P5uhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Doeg9OFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77480C4CEF0;
	Wed, 17 Sep 2025 12:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113632;
	bh=mk/OacGMi18J0H06QVApt2uqor3QtFRpoGD81kzpw3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Doeg9OFhUgA166uV51cGaK96hEMOaWu5aRj5fpNNqzoXRTl6QpsjH6zIvxWMhxp2U
	 5HsaB0JH2GTi32ljV3PG8ELwbJ3WXG2H165GBjEU3sWI1qI8aHxosJZqrhEA2UV/k+
	 OnhtatplJbEe98BZ/ieJghxWIrsXE9SS+GzWswxw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 130/140] usb: gadget: midi2: Fix missing UMP group attributes initialization
Date: Wed, 17 Sep 2025 14:35:02 +0200
Message-ID: <20250917123347.493724225@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 21d8525d2e061cde034277d518411b02eac764e2 upstream.

The gadget card driver forgot to call snd_ump_update_group_attrs()
after adding FBs, and this leaves the UMP group attributes
uninitialized.  As a result, -ENODEV error is returned at opening a
legacy rawmidi device as an inactive group.

This patch adds the missing call to address the behavior above.

Fixes: 8b645922b223 ("usb: gadget: Add support for USB MIDI 2.0 function driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20250904153932.13589-1-tiwai@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_midi2.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -1601,6 +1601,7 @@ static int f_midi2_create_card(struct f_
 			strscpy(fb->info.name, ump_fb_name(b),
 				sizeof(fb->info.name));
 		}
+		snd_ump_update_group_attrs(ump);
 	}
 
 	for (i = 0; i < midi2->num_eps; i++) {



