Return-Path: <stable+bounces-69963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D22295CD29
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 15:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7031C2163A
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDE81862BE;
	Fri, 23 Aug 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUj5L83K"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C1183061;
	Fri, 23 Aug 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418432; cv=none; b=pr+A7KjCnnmxc/7s4k0+4Se8kctSHYVKUjKuXvZjsT7hvqQ7OJb0mMf/EDdblq9W9yNkNSYI7Boj/+grPzEshc7yP0gtG+HFigMg3XiaLYVH+OrnonipbwyT1hVhfOTxJQN5zMKx82U1af+xIVr6ntbqWWAfIjFtBgA8UbDBI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418432; c=relaxed/simple;
	bh=nm0P3qLXV1XMzA7xq1pcWKSuPpJGsf16gUPTFe+Xqmw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uUohDxYCRdljEnWH4vJLDx3GiECGGjmiLbJjUmURCJjEeBQftDMW7m4+xZG8yDWQ5eMOvnn2XleeNP0XivoLJzTa/2+30gF8LC8UCKH5YZcw4ddFuxj2PWfNOBOad7k/GWeGcx3Y4eyIzF2uDG/qMsW3OCjHASeG+vmSgKxRwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUj5L83K; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3719398eafcso1009527f8f.1;
        Fri, 23 Aug 2024 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724418429; x=1725023229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nm0P3qLXV1XMzA7xq1pcWKSuPpJGsf16gUPTFe+Xqmw=;
        b=WUj5L83KlNWeSm2L+9Sy2Ij5uD32uuxcjPfLd/7jOklhL7vVo6xa6JKAKmjWPfxqHJ
         zmAgVu33Ot3gBk8YXvmYP7Gqw5dqPQjIHOEASJ6Zsv8yuhKARpzmn+CD+bK1eRfQI2SR
         BBGmthDM8N94t4EJxCed10ukPOnNtxicA17m+vuYi9tO1ts2ELtp88RJp1MG/wvw9s15
         Ot04LXxTPne5VgTq34/DlDdC9Hbl45r6tRseFDM/4b6VE+FVuP++O48X2MATu43W7nUo
         i53Jr82FtFusNbK/B7TYzk25Iu1H4wTfJqEnozOucvnUtzbxwcv23Jb2qbD0n5VHoPxo
         1PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724418429; x=1725023229;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nm0P3qLXV1XMzA7xq1pcWKSuPpJGsf16gUPTFe+Xqmw=;
        b=ONOccJzmUu6wRKrJOSL1VyNbdeMFGMtw1o1/oAAn7KXS+EXB4bI5jV7zM8zGvqU9Al
         VTMh+HHcWjSHcB7r3RAITB4V4sG5GUnv12uN1uvePz3Yn6QmavimV0t/Mmh1gr01o+gJ
         hFNR8Q7GqFv96X2d6XvpgGmuc7ZcyEnvGPJ/SHCGZgrZXT9C/U4WfE2pfc1RzvsBkrXk
         Q/pcnEcGy1R3BLMo+aiE4x6slb35oZNGIkZpzDqQpcnuG5A3pO9/XG/GpgH//URyJQnX
         d1hOF2TwfE+ARSArZTgG6s1DVCopj2SBarnlkguZRXgpCfE2jfgk0eZs1PM2TqUf5WOM
         zqgg==
X-Gm-Message-State: AOJu0Yw+0AqeknMcSIY8CipFalZinUb6VMwQvl732hIVQeqvRgUnd49n
	M0lhrKtyZCycGPo04M50xZTIhtroU7t07cctDEisP5BgLUqJBA9EtDqI4O4I7fYMYMHB0uFliG4
	ulIfOeqNDCrWINvG6Qd7IAkrWJ6YIAu5hgMuwzA==
X-Google-Smtp-Source: AGHT+IH9o05P0FYtv+3nd52PSlROm27y3qX+x61RXYD50SM+G5IdBgTPEko9m0ReVKWtJvnqD7kvx8KAUQ81ntOaj2w=
X-Received: by 2002:adf:ec48:0:b0:371:8eb3:8c64 with SMTP id
 ffacd0b85a97d-373118ee972mr1435997f8f.54.1724418428111; Fri, 23 Aug 2024
 06:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrey Kashtanov <austrum.lab@gmail.com>
Date: Fri, 23 Aug 2024 17:06:56 +0400
Message-ID: <CA+Qy7vRQnWx+0Au06hPbgASTRTxtNnbMxV=0jmJaZtsEBQ81zg@mail.gmail.com>
Subject: ASUS GA402XY (ACL285) Headset mic not working with 6.9 and 6.10 kernel
To: stable@vger.kernel.org
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/mixed; boundary="000000000000da31a4062059737d"

--000000000000da31a4062059737d
Content-Type: multipart/alternative; boundary="000000000000da31a2062059737b"

--000000000000da31a2062059737b
Content-Type: text/plain; charset="UTF-8"

Greetings!

I've run into a problem with an external microphone (3.5 jack headset) and
fresh kernels (6.9, 6.10)
When using the 6.9 or the 6.10 kernel system doesn't see an external mic
from the headset (3.5 jack). Instead, there's only an internal mic
plugged/available in the system.
When using the 6.8 kernel or less it's okay, I can use mic from the
headset. So currently I'm on 6.8.12.

Also opened a bug on bugzilla (
https://bugzilla.kernel.org/show_bug.cgi?id=219158)

Laptop Model: Asus ROG G14 GA402XY
Codec: Realtek ALC285 + Cirrus logic cs35l41
OS: Debian Testing
Kernel: 6.9.x, 6.10 represents the issue, 6.8.x no
DE: Gnome 46, wayland

What I've tried:
- Play with snd_hda_intel model parameters from here:
https://www.kernel.org/doc/html/latest/sound/hd-audio/models.html?highlight=headset+mic
ex: options snd_hda_intel model=dell-headset-mic
- Retask jack with hdajackretask
- Install a fresh system on another ssd (latest PopOS) - after kernel
update to 6.9.x (from the repository) it's the same issue.

--000000000000da31a2062059737b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Greetings!<br><br>I&#39;ve run into a problem with an exte=
rnal microphone (3.5 jack headset) and fresh kernels (6.9, 6.10)<br>When us=
ing the 6.9 or the 6.10 kernel system doesn&#39;t see an external mic from =
the headset (3.5 jack). Instead, there&#39;s only an internal mic plugged/a=
vailable in the system.<br>When using the 6.8 kernel or less it&#39;s okay,=
 I can use mic from the headset. So currently I&#39;m on 6.8.12.<br><br>Als=
o opened a bug on bugzilla (<a href=3D"https://bugzilla.kernel.org/show_bug=
.cgi?id=3D219158">https://bugzilla.kernel.org/show_bug.cgi?id=3D219158</a>)=
<br><br>Laptop Model: Asus ROG G14 GA402XY<br>Codec: Realtek ALC285 + Cirru=
s logic cs35l41<br>OS: Debian Testing<br>Kernel: 6.9.x, 6.10 represents the=
 issue, 6.8.x no<br>DE: Gnome 46, wayland<br><br>What I&#39;ve tried:<br>- =
Play with snd_hda_intel model parameters from here: <a href=3D"https://www.=
kernel.org/doc/html/latest/sound/hd-audio/models.html?highlight=3Dheadset+m=
ic">https://www.kernel.org/doc/html/latest/sound/hd-audio/models.html?highl=
ight=3Dheadset+mic</a> ex: options snd_hda_intel model=3Ddell-headset-mic<b=
r>- Retask jack with hdajackretask<br>- Install a fresh system on another s=
sd (latest PopOS) - after kernel update to 6.9.x (from the repository) it&#=
39;s the same issue.<br></div>

--000000000000da31a2062059737b--
--000000000000da31a4062059737d
Content-Type: application/zip; name="dmesc_asound.zip"
Content-Disposition: attachment; filename="dmesc_asound.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_m06q6r2u0>
X-Attachment-Id: f_m06q6r2u0

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
AAEvurxmUEsFBgAAAAAEAAQAUgEAABUWAAAAAA==
--000000000000da31a4062059737d--

