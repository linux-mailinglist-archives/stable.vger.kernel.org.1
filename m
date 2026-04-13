Return-Path: <stable+bounces-235887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDq8HQxt3GnVQgkAu9opvQ
	(envelope-from <stable+bounces-235887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:11:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 082903E72CB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA4CE300AEF1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3ED37EFED;
	Mon, 13 Apr 2026 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+qlZgkW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9DF37DE80
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053510; cv=none; b=Fs9cqI7XaEP4ZuVqamUteb80R2wH3Nmx5qTPOBB8JjPNR0L0Ffau+lqnbBfNDRI7PSqrAQGuD3W1ghQ7e/xSJksu4EMoq4e6YrwamRAsqQ/h4+vIgkGxppgZLSxGHpGi8mlWHF0UL/m6OEJhtPLyvJlMgbLL/S4aWuWV6ixKHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053510; c=relaxed/simple;
	bh=4L8WQU1yUwKkw0WOIQz0G++XTKaurTWNP8GscxFwjaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vhdy1unmkn/yy8swxsGVlImFLv1hIjujJNAPXpTsqVB1z/VMWf4rB3aGqNoFLzcI845VLb+DvnXvOusNCgjlSfwJy8AvVpIdA5MfqddVddm9nkrfy+ebn+WWAFGA8VXxlE6xCBW8Ftx0lallpINOKPb5em5TT7gB0g24uaiEJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+qlZgkW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c766cf593daso2780776a12.3
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776053496; x=1776658296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpHkHpxIq3fLcPGxqj57fWIAvAweXTqSaoO59Lg6zL0=;
        b=f+qlZgkWGIvuoHFZBERdrxR5gCMoLXZQv7wiCcES2a2yDkvIaTPiG10ecQWjYCmBf2
         pWYEGIlQgadKh/YoPjFb6UW5zCsugemdQZc5DiEUh+1YEj8BI6R8jxiVzZlKZ5oZCIy7
         5Zel0bVBPaD34s9SSZAm7bK02ITmwh6ngILHNRj2meM8EWIldjojOkElubKUcAYFpHEh
         Nds1RSaxzRZ5XmGQMS0uTCQX7nV7qUv/GKp8z9zSdmKrqIsg2KzHa0aHQ8QnkMcknzSD
         CvEnjPz7Yfc7D/Xlkk3vynrvkBNMw6UbQajhGIV7WLGg6uZ06zwDudueaKl8eWy7EfC4
         3uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053496; x=1776658296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpHkHpxIq3fLcPGxqj57fWIAvAweXTqSaoO59Lg6zL0=;
        b=OvyAfHtQLiuiGw90duAATXYCD813IGWcPux48/Dp4yC6qnxLVnQ854K9WlkHf38HWx
         BGLjx8g/+pt0TkIR6kZqQ/U8c/ISadeZwCW1ii8vhr9PftQcZ80AKQTOGySurJ524Hpy
         zhgtoqamm0+bcSnANPxZ37D6uE4Er+dGL8sVIrwBijXTWm/xu8tgUYZ9fLAcQWIWRFTp
         r7iFB4BP460TB6QTgnYlxCV8FL9hTp6/ieJloBiZL2lioQK3OiV/JPf/6BO1oSOPxKmF
         tRhlUP1niatvdRRmSc7FM2EVrxEolh49orZFk5PRSkF24fx1Sf7RPFpB8uHAmlSk1pcd
         fPeg==
X-Forwarded-Encrypted: i=1; AFNElJ8qENglfHx3NPrTHcE5cAVJhCJjioysrwFMjs9omJJFRyCiTPTfnaDdtvd8cPdvNHAUl31qW30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYBJOCK5FEe7nKNaoRTKgexETg/AwruybLDtnD2pT3AQ2oVCk
	YShD8op4yx5Q3ypUVuCIX8ynojIqr0Z35IB7jaUlcGlJ9l5uSqpxC18h
X-Gm-Gg: AeBDieuauuNj2aJjC+l6hnfDbgobNN3cJseWmLDsl5RYHTMckYAHP2dIe6bZn/UCmnL
	ITcwpbdTvw0j2jlb2I3Re10zN2+aQLDicUDT5O9yVNgmSKnz/XEkdcG+8MIVVidyRa+enGv1FoR
	g1AXB/vrdyXO6T7WXUUEdSDrALaGpXlu6Jhzccjstj713nBtFDrQ49UPcMVrXrsBCHPN3zO6t8E
	p3fvIFEqkGfGOW8VlOHW8dJpl3Xo3yv+GAc3uZvaENWuIRK/C5GCbu3QPeNi7oFjrxIWDUp81Bn
	pFR41+S760OB3xv0MbfVPn9UEvWhhDD30JR/S1HgOgjFk8tE167Ic5TyRECEWyaZb4U1vUIyqGW
	zYa1fVramO+yK99XSDDl3QqvwMmaW091iBJfJidbQS8kvgL7uKEmC41rQtAPiUM7tVHmckb+XHr
	fSPYA3hFdHxXltuewIpFRCLWBF26uZaAZ9OgJVAtoKzw00CwzSzTahdwUcnY/k5WxgHp5t/chOX
	F/CBDTdk4g6
X-Received: by 2002:a05:6300:210f:b0:398:92ef:1d95 with SMTP id adf61e73a8af0-39fe3d85ec9mr12452524637.21.1776053495799;
        Sun, 12 Apr 2026 21:11:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:6580:9cc0:8700:96ae:8c3d:9c98:97d9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ff41dsm7997462a12.2.2026.04.12.21.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 21:11:35 -0700 (PDT)
From: Berk Cem Goksel <berkcgoksel@gmail.com>
To: tiwai@suse.de
Cc: andreyknvl@gmail.com,
	berkcgoksel@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	stable@vger.kernel.org,
	tiwai@suse.com
Subject: Re: [PATCH 2/2] ALSA: caiaq: take a reference on the USB device in create_card()
Date: Mon, 13 Apr 2026 07:11:25 +0300
Message-Id: <20260413041125.1134788-1-berkcgoksel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87tstjgwcj.wl-tiwai@suse.de>
References: <87tstjgwcj.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-235887-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,perex.cz,suse.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berkcgoksel@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 082903E72CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

My bad on the Fixes tag. I'm on Linus's tree, master at                                                                                                
9a9c8ce300cd (v7.0-rc7-227-g9a9c8ce300cd). Respinning as v2:
                                                                                                                                                         
  1/2: Fixes: 8e3cd08ed8e5 ("[ALSA] caiaq - add control API and more input features")                                                                  
  2/2: Fixes: b04dcbb7f7b1 ("ALSA: caiaq: Use snd_card_free_when_closed() at disconnection")                                                           
  
Patch v2 is here: https://lore.kernel.org/all/20260413034941.1131465-1-berkcgoksel@gmail.com/                                                                                                                                        
Sorry for the noise.
                                                                                                                                                         
Thanks,         
Berk

