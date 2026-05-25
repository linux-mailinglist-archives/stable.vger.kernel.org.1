Return-Path: <stable+bounces-254072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHkVO2PVE2oCGgcAu9opvQ
	(envelope-from <stable+bounces-254072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:51:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B3E5C5C78
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1049A3010D85
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AA8324B32;
	Mon, 25 May 2026 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgXGM1aK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72A3176E0
	for <stable@vger.kernel.org>; Mon, 25 May 2026 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779684701; cv=pass; b=Jbog2V7rKSrTbo8gmyp0wzrzn8TVABW0iSkXAOrZqvvz/w2HvVSjZFYCfyR61aI7uWrQvAem86dR8SOKVBKqPwKa3eEszRIeYNNfrTL1Gmg10RfiRCBbqGtsjcLvhAFkX3v7WfwvQ9vYfQ0Syh5PcIYpnDqBOkUNq9ayOBQUCKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779684701; c=relaxed/simple;
	bh=q6p0ooq6Sno5Jb5VpwX5zDubbrYII1VdagBmZdZSNXo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LyIVBEtUmS8Ci1rY4h8KnIQ9WjYhZx4WzNtqwy2cExS5ducL9BfjwWCLYf1Wbardst4Mv2MqhV7I4hQcRkIINRhpsaRBEdJ4EYCVrU5QyAtOpCnFH3TFp0PiNsAxxMcuw9bVpg7yVZGE4UCs6G9W2/FsVtLooP8NjfYtIDvGqX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgXGM1aK; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dcdaf06498so6041929a34.2
        for <stable@vger.kernel.org>; Sun, 24 May 2026 21:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779684697; cv=none;
        d=google.com; s=arc-20240605;
        b=Ny2qVgDxpCpp/7z9C3xUOfG+nx/cKRP0DdyLr77jm0zjyuP2mlcFr25orzwl81UIas
         KP4C494peElqaQIwKiyIL1L7Vpd3I9TukPyk3Gt2bxlZMiigokwQl51nsFPNjv4mUqtv
         oZUAsInIwf34ld2zznwEHlMfmGne5oHUg5kDkpBKkhWDLyRa10xi34MxoXFTxIfJSwP1
         pqBQXpbdxkthVL3sSsER+fXyKKNZCsJflT063WGgnq8PC++rVMMNwnOU/p2BVF4CGSln
         LKDPz8rJUf1GhFXSre8a0JiHHd6+WaGRDe+o4ufkJYtpod8vIIHSWMkHtoWSE7pvQ2Fg
         VZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=K/z1bhwr6Ofo8w1oLQvfJdmWvPh/HW9LkJm8LXPq2fA=;
        fh=dqHZjp1XtxQCaLafhhGydzllbAp8As6nOQRc6z4vhBc=;
        b=MobSzq1cIYmS1GfMfn1+h5RT7BGFbYrf9n/XXXThVFzFqYxu2wGPeLZZ1b4NGBrX1/
         ERua6fAj3sKQY2aOHrCIlmmL2EEtXXUgve4jhzNU9G2lyvv2OEzyfJssMXQS4ijbRmHo
         EYnydHjXivtDn79t1WeTurQMwRrsSUdE0hSle/4QRE9hv4/aVR7YIs1ZcfKPDC+zWfpG
         6UaR0Xktr1/hE7m/zMRj8re4SPSd8P/muSQdqLAKSXLjY+ZOZUxoFl4zZNlb9fd34bFc
         dncwjzgc7BD75YbinaVK6H8ZTPpmOK7wlqsYPrrynSCiFd4YVSzQNO8yqdZ32E4x2EbI
         kjdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779684697; x=1780289497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K/z1bhwr6Ofo8w1oLQvfJdmWvPh/HW9LkJm8LXPq2fA=;
        b=ZgXGM1aKRe5WeBnipOGlnaYxRczkiE0yKaIkkCt2xduEQcDuslMSv5ChRcWcNjVstp
         sNUNGvEVG4VE/H0NF+THhs+8z1owAqNINPr7MZtT1hGNmsLIJ+/505Uo2IA1Nf9O0nY5
         UqNk6TnlaX+BLdkuiI3VkGVSnZKPZqS72iuFsQj7b8LW1OvKbqcXi4ZJoYIkJNNTVxrb
         iGt3xVTabW3LXsPgXf3O4N7ePLl4Au+DUOGMu7jm8QBRssFVBTCcU0Ys2ObzYuWNip0w
         Q++2iFb6WNZsdaMBxx2Ymku6/GuLDeAo1wYosii45YvrzxFKXA7GVwefmbsnQEXYW1Ez
         3XCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779684697; x=1780289497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/z1bhwr6Ofo8w1oLQvfJdmWvPh/HW9LkJm8LXPq2fA=;
        b=AxjM0ybolUKOEJZW8qwbtoGHuNmHfY13Rq36iM2S9aZkrTYRZsjC114LNkgD09aN8L
         eKxnFC5/E0l4464/acBdoLg8zRHOoewHvpfOpaI1/G9vS0vIMSvpF+frdIY1eSXJyde9
         AFv8k74aUAWGwrGUp7W7ORzG8/nHn7i8s45ZVpUKKm+BMAkbIsQkX+wzNgxOTg9bmZ1v
         MoUob2WFOpGEFZj2UcG0j4GM1yn2FAVItQTVh0tO5iZxJ3G5XJKGWbBnYMqZv7UAMpjD
         z1ZCUhHFJP58N4l5Ch6KhjcmGwSLZzQcbh5TXNN3nbcB+9Fz5JL0TuuJnh97Zj7/f+Ga
         BsJA==
X-Forwarded-Encrypted: i=1; AFNElJ8j2x5HbB6noGY91loMk/l59OkP4peg5W1Y1E8dSyLddk5Xqn74wq1KASHWjpd2CQQ66HhFd6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42Kuwje+VaNpD+hDibMgvPjMZVyWu1saVGXBsPsi2MyLEQJWu
	iEDqNVcdUu81+l3bGlS/0HUueN97tuY2OGTGtJoRz2UhpBhLTjzWhacxcOAfiudnhP0tBAfH5yD
	eJnHoKUBzw84vahE9CZS85kUoVpKdSKU=
X-Gm-Gg: Acq92OFMTpg2dWIPoUiwa1sSyM0kodBU9Kx+ZCReNNbqopkd6+8hMMU3bHbxLPA3RmE
	8BoRE8Lkv4zIwxA845v0+ZpCRdSUojFcmQhLjoZvzr19/0tilrYtoumirPws2LqequYn6KPSDJw
	p+uizc0h7W+f+DBbA9JqhUFTsp6D8no4LTx6CT6MwQfaz189Z9fRpnCZ9MFB/33hv8e1fD7RubH
	Ih8MMy9NLyQag4orumeRAyZ1ET2U1Im8oBTgs0HYVsP15Ry3hkVqJxPPh0K4WlWePKB2jEGWmDz
	N8ie/bfS8qBKLHYGuLoGLm7mqvyMbjZATozj7Lh6Mzb54gmp0XFIYb9ikgq8owijmQ+VVbhP0Q=
	=
X-Received: by 2002:a05:6830:20ca:b0:7e5:6d2e:acd9 with SMTP id
 46e09a7af769-7e5fefcbc8dmr5091047a34.12.1779684696881; Sun, 24 May 2026
 21:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adrian Korwel <adriank20047@gmail.com>
Date: Sun, 24 May 2026 23:51:25 -0500
X-Gm-Features: AVHnY4I6eFiYZiSJ4FBlGh9DSgjGlQkuKLwHkU2mL60pbZoWbCr5zh5szgA6QYY
Message-ID: <CADgB2mEP106R3uzh9H=-yCjNLOcn5m+0eEayTb_1i=nh=EUP_g@mail.gmail.com>
Subject: [PATCH] usb: typec: thunderbolt: cancel work before altmode is removed
To: linux-usb@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254072-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 56B3E5C5C78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tbt_altmode_remove() frees resources associated with the Thunderbolt
altmode but does not cancel the pending work item before returning.
Since tbt is allocated with devm_kzalloc(), it is freed automatically
when the device is released after remove() returns.

The work item tbt_altmode_work() can be scheduled via schedule_work()
from tbt_altmode_vdm(), tbt_altmode_activate(), and the probe path,
and may still be pending or running when tbt_altmode_remove() returns.
The work function accesses tbt->lock, tbt->state, tbt->alt, and
tbt->plug[] =E2=80=94 all of which reside in the freed struct, resulting in
a use-after-free.

Fix by calling cancel_work_sync() in tbt_altmode_remove() before
releasing any resources, ensuring no work item referencing tbt can
run after teardown begins.

Fixes: 100e25738659 ("usb: typec: Add driver for Thunderbolt 3 Alternate Mo=
de")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/typec/altmodes/thunderbolt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/altmodes/thunderbolt.c
b/drivers/usb/typec/altmodes/thunderbolt.c
index 32250b94262a..57c8dff0c51f 100644
--- a/drivers/usb/typec/altmodes/thunderbolt.c
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -303,6 +303,8 @@ static void tbt_altmode_remove(struct typec_altmode *al=
t)
 {
        struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
+       cancel_work_sync(&tbt->work);
+
        for (int i =3D TYPEC_PLUG_SOP_PP; i >=3D 0; --i) {
                if (tbt->plug[i])
                        typec_altmode_put_plug(tbt->plug[i]);
--=20
2.43.0

