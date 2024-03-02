Return-Path: <stable+bounces-25765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB1186ED72
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 01:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E7B21337
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9E0A47;
	Sat,  2 Mar 2024 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=totalphase-com.20230601.gappssmtp.com header.i=@totalphase-com.20230601.gappssmtp.com header.b="BUrv9u+n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821FF7E9
	for <stable@vger.kernel.org>; Sat,  2 Mar 2024 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709339271; cv=none; b=daLJsbqCYAabXkVRvwP5wKGOTtRYURy739GoVH2cyGvMPTke6Tt+vNd431XhAnaK2xmbb+nC/3AcNKzLrnf4KM8Z6fE1cMTVoFg2oupy4rXt4sBY48cjYTb0hZ9JnoLJ/DFQM/hZvkSCnXYOFvbRuoMEOzTMQmplHXXRb1/1FPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709339271; c=relaxed/simple;
	bh=aYq0NwpZgLzqnF+6us/5233DaefXp5Llrj84sDhRT1k=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=EJ043p0UUBcpz+Zg3aUpjxuukIXjT6iyjyOv6YnAeVqMn0lLbjWgeauXz7+ZsHrA4KkYkDVj9L/Wd7K/jGbsAKFHF1+vTvH++8PSwCDwoegdguQOCYa7kTqVUzHDrULMvxr8gLE4vlqcIWmB7iBn3OLaGooYSXi0vPBDYh+VogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.totalphase.com; spf=pass smtp.mailfrom=totalphase.com; dkim=pass (2048-bit key) header.d=totalphase-com.20230601.gappssmtp.com header.i=@totalphase-com.20230601.gappssmtp.com header.b=BUrv9u+n; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.totalphase.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=totalphase.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-1dcafff3c50so23333735ad.0
        for <stable@vger.kernel.org>; Fri, 01 Mar 2024 16:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=totalphase-com.20230601.gappssmtp.com; s=20230601; t=1709339269; x=1709944069; darn=vger.kernel.org;
        h=thread-topic:thread-index:mime-version:subject:message-id:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/ETYQf4jeeeUpCfwfuE8yvLTcNPLx2Ezp/zSgWjEYs=;
        b=BUrv9u+nwnfMGMplf3tFwGjXUcqFLZLKZTOTjN70mrBa5xC3SJ5Gi5vsFHRdhfLY7g
         GHifpfGR6uj6oBB4SVJ184JmU/goKL5UWtaHxBL2xtADcsKD8Yu9a8mRmm/joiFKFSJe
         4dwCFF92WqklqpjmmGv/Nm1/AbQU2mKq5vFG5ompfZBMbiU1nSJPw9Cq/OBBhZFIJIUp
         qDLoVsD1vuosKhXLcPZ8R5lbnf6d4jCp4yEdsy8vJ2+cjBIZOAmPIp5Hf9YZxl3R7i7b
         95fmOYhgroV/BsVTRGWFgukOHQa68yJqhmUrQLcERY+HZ8FLEbI4hzOHtVHp6W5B8UPU
         OVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709339269; x=1709944069;
        h=thread-topic:thread-index:mime-version:subject:message-id:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/ETYQf4jeeeUpCfwfuE8yvLTcNPLx2Ezp/zSgWjEYs=;
        b=qsiYtolE0xCVlBohETRIGG5bHeWXdjWGB+WI2bd7c1UU+WNfzAYg/JJgmV1jlxo89g
         RQ7zTiPQnbmve42uw4RxzUBKxjlFpBDWdaQrH2U1Ol/fRXo88xEY1tP14E8ftW/TEDHA
         oNkv6IJbrzx/YbIo6lMrMLi/79iuC1z28tRkshIsqW+r3tmX4Btii16x8KBjY0A28iyf
         RPpoMosSurRmg5aicNJPomoek8zxSNO4J+4/ZGtB9UDV1G2+EebhSHimIn0Xs4bfM9ql
         W9FIhugmvKGk+0qL3L1QeF0kHNczWhphPI9qwYAbnYbi+WavEi124+eCgj/iyz6pno8O
         hiYQ==
X-Gm-Message-State: AOJu0YwaUXAAFTbagN9kPU4PCjTJvsclGmf2C4rQX/xlsyubEYTMCQCB
	4UapaGLyOng0a2S/K/Ap5VsFJSVAVYceI6I9qPvtRNm1SCPSExa6M+hJmTeCPQaqd95ZswRDlVk
	+Hd+A/iRjAUjaH/9GWS1FLvKeuK4d2elW
X-Google-Smtp-Source: AGHT+IEqdlgkkFwW60V75jejg7YZdSlmLn3jzp41j+//DPm4sU4aE6RtedzSeq3x4BMBqPbHuMJgkCsDo1Fp
X-Received: by 2002:a17:902:e944:b0:1dc:226d:d85f with SMTP id b4-20020a170902e94400b001dc226dd85fmr4344686pll.69.1709339268708;
        Fri, 01 Mar 2024 16:27:48 -0800 (PST)
Received: from postfix.totalphase.com ([65.19.189.126])
        by smtp-relay.gmail.com with ESMTPS id f4-20020a170902684400b001dca40c31c3sm199558pln.104.2024.03.01.16.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:27:48 -0800 (PST)
X-Relaying-Domain: totalphase.com
Date: Fri, 1 Mar 2024 16:27:46 -0800 (PST)
From: Chris Yokum <linux-usb@mail.totalphase.com>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Message-ID: <949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com>
Subject: 6.5.0 broke XHCI URB submissions for count >512
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_833958_1937603355.1709339266737"
Thread-Index: /JaF4kMIYC1hrKWG7dmd53++d8Hw7Q==
Thread-Topic: 6.5.0 broke XHCI URB submissions for count >512

------=_Part_833958_1937603355.1709339266737
Content-Type: multipart/alternative; 
	boundary="=_30356fbf-110c-4a07-a24b-a445a01b25e1"

--=_30356fbf-110c-4a07-a24b-a445a01b25e1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



We have found a regression bug, where more than 512 URBs cannot be reliably submitted to XHCI. URBs beyond that return 0x00 instead of valid data in the buffer. 




Our software works reliably on kernel versions through 6.4.x and fails on versions 6.5, 6.6, 6.7, and 6.8.0-rc6. This was discovered when Ubuntu recently updated their latest kernel package to version 6.5. 




The issue is limited to the XHCI driver and appears to be isolated to this specific commit: 

[ https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb?h=v6.5&id=f5af638f0609af889f15c700c60b93c06cc76675 | https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb?h=v6.5&id=f5af638f0609af889f15c700c60b93c06cc76675 ] 




Attached is a test program that demonstrates the problem. We used a few different USB-to-Serial adapters with no driver installed as a convenient way to reproduce. We check the TRB debug information before and after to verify the actual number of allocated TRBs. 




With some adapters on unaffected kernels, the TRB map gets expanded correctly. This directly corresponds to correct functional behavior. On affected kernels, the TRB ring does not expand, and our functional tests also will fail. 




We don't know exactly why this happens. Some adapters do work correctly, so there seems to also be some subtle problem that was being masked by the liberal expansion of the TRB ring in older kernels. We also saw on one system that the TRB expansion did work correctly with one particular adapter. However, on all systems at least two adapters did exhibit the problem and fail. 




Would it be possible to resolve this regression for the 6.8 release and backport the fix to versions 6.5, 6.6, and 6.7? 

#regzbot ^introduced: f5af638f0609af889f15c700c60b93c06cc76675 

--=_30356fbf-110c-4a07-a24b-a445a01b25e1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><p style=3D"margin: 0px; padding: 0px; colo=
r: rgb(23, 43, 77); font-family: -apple-system, BlinkMacSystemFont, &quot;S=
egoe UI&quot;, Roboto, Oxygen, Ubuntu, &quot;Fira Sans&quot;, &quot;Droid S=
ans&quot;, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14px; font-st=
yle: normal; font-variant-ligatures: normal; font-variant-caps: normal; fon=
t-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-=
indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, =
255); text-decoration-thickness: initial; text-decoration-style: initial; t=
ext-decoration-color: initial;" data-mce-style=3D"margin: 0px; padding: 0px=
; color: #172b4d; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI=
', Roboto, Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'Helvetica Neue', san=
s-serif; font-size: 14px; font-style: normal; font-variant-ligatures: norma=
l; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orp=
hans: 2; text-align: start; text-indent: 0px; text-transform: none; widows:=
 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal;=
 background-color: #ffffff; text-decoration-thickness: initial; text-decora=
tion-style: initial; text-decoration-color: initial;">We have found a regre=
ssion bug, where more than 512 URBs cannot be reliably submitted to XHCI. U=
RBs beyond that return 0x00 instead of valid data in the buffer.</p><p styl=
e=3D"margin: 0px; padding: 0px; color: rgb(23, 43, 77); font-family: -apple=
-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, =
&quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: no=
rmal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; wido=
ws: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: norm=
al; background-color: rgb(255, 255, 255); text-decoration-thickness: initia=
l; text-decoration-style: initial; text-decoration-color: initial;" data-mc=
e-style=3D"margin: 0px; padding: 0px; color: #172b4d; font-family: -apple-s=
ystem, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans',=
 'Droid Sans', 'Helvetica Neue', sans-serif; font-size: 14px; font-style: n=
ormal; font-variant-ligatures: normal; font-variant-caps: normal; font-weig=
ht: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent=
: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-str=
oke-width: 0px; white-space: normal; background-color: #ffffff; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial;"><br data-mce-bogus=3D"1"></p><p style=3D"margin: 0px; paddin=
g: 0px; color: rgb(23, 43, 77); font-family: -apple-system, BlinkMacSystemF=
ont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, &quot;Fira Sans&quot;, &=
quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif; font-size: 1=
4px; font-style: normal; font-variant-ligatures: normal; font-variant-caps:=
 normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: =
start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px=
; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rg=
b(255, 255, 255); text-decoration-thickness: initial; text-decoration-style=
: initial; text-decoration-color: initial;" data-mce-style=3D"margin: 0px; =
padding: 0px; color: #172b4d; font-family: -apple-system, BlinkMacSystemFon=
t, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'Helvetic=
a Neue', sans-serif; font-size: 14px; font-style: normal; font-variant-liga=
tures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing:=
 normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: n=
one; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-sp=
ace: normal; background-color: #ffffff; text-decoration-thickness: initial;=
 text-decoration-style: initial; text-decoration-color: initial;">Our softw=
are works reliably on kernel versions through 6.4.x and fails on versions 6=
.5, 6.6, 6.7, and 6.8.0-rc6. This was discovered when Ubuntu recently updat=
ed their latest kernel package to version 6.5.</p><p style=3D"margin: 0px; =
padding: 0px; color: rgb(23, 43, 77); font-family: -apple-system, BlinkMacS=
ystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, &quot;Fira Sans&qu=
ot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif; font-s=
ize: 14px; font-style: normal; font-variant-ligatures: normal; font-variant=
-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-a=
lign: start; text-indent: 0px; text-transform: none; widows: 2; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-col=
or: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration=
-style: initial; text-decoration-color: initial;" data-mce-style=3D"margin:=
 0px; padding: 0px; color: #172b4d; font-family: -apple-system, BlinkMacSys=
temFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'He=
lvetica Neue', sans-serif; font-size: 14px; font-style: normal; font-varian=
t-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-sp=
acing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transf=
orm: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; wh=
ite-space: normal; background-color: #ffffff; text-decoration-thickness: in=
itial; text-decoration-style: initial; text-decoration-color: initial;"><br=
 data-mce-bogus=3D"1"></p><p style=3D"margin: 0px; padding: 0px; color: rgb=
(23, 43, 77); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe U=
I&quot;, Roboto, Oxygen, Ubuntu, &quot;Fira Sans&quot;, &quot;Droid Sans&qu=
ot;, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14px; font-style: n=
ormal; font-variant-ligatures: normal; font-variant-caps: normal; font-weig=
ht: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent=
: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-str=
oke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); =
text-decoration-thickness: initial; text-decoration-style: initial; text-de=
coration-color: initial;" data-mce-style=3D"margin: 0px; padding: 0px; colo=
r: #172b4d; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Rob=
oto, Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-seri=
f; font-size: 14px; font-style: normal; font-variant-ligatures: normal; fon=
t-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: =
2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; backg=
round-color: #ffffff; text-decoration-thickness: initial; text-decoration-s=
tyle: initial; text-decoration-color: initial;">The issue is limited to the=
 XHCI driver and appears to be isolated to this specific commit:</p><p styl=
e=3D"margin: 0px; padding: 0px; color: rgb(23, 43, 77); font-family: -apple=
-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, =
&quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: no=
rmal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; wido=
ws: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: norm=
al; background-color: rgb(255, 255, 255); text-decoration-thickness: initia=
l; text-decoration-style: initial; text-decoration-color: initial;" data-mc=
e-style=3D"margin: 0px; padding: 0px; color: #172b4d; font-family: -apple-s=
ystem, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans',=
 'Droid Sans', 'Helvetica Neue', sans-serif; font-size: 14px; font-style: n=
ormal; font-variant-ligatures: normal; font-variant-caps: normal; font-weig=
ht: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent=
: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-str=
oke-width: 0px; white-space: normal; background-color: #ffffff; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial;"><a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/t=
orvalds/linux.git/commit/drivers/usb?h=3Dv6.5&amp;id=3Df5af638f0609af889f15=
c700c60b93c06cc76675" class=3D"external-link" target=3D"_blank" rel=3D"nofo=
llow noopener" style=3D"color: #0052cc; text-decoration: none; cursor: poin=
ter;" data-mce-href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torv=
alds/linux.git/commit/drivers/usb?h=3Dv6.5&amp;id=3Df5af638f0609af889f15c70=
0c60b93c06cc76675" data-mce-style=3D"color: #0052cc; text-decoration: none;=
 cursor: pointer;">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git/commit/drivers/usb?h=3Dv6.5&amp;id=3Df5af638f0609af889f15c700c60=
b93c06cc76675</a></p><p style=3D"margin: 0px; padding: 0px; color: rgb(23, =
43, 77); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quo=
t;, Roboto, Oxygen, Ubuntu, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, =
&quot;Helvetica Neue&quot;, sans-serif; font-size: 14px; font-style: normal=
; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px=
; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-w=
idth: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-=
decoration-thickness: initial; text-decoration-style: initial; text-decorat=
ion-color: initial;" data-mce-style=3D"margin: 0px; padding: 0px; color: #1=
72b4d; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, =
Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif; fo=
nt-size: 14px; font-style: normal; font-variant-ligatures: normal; font-var=
iant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; te=
xt-align: start; text-indent: 0px; text-transform: none; widows: 2; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background=
-color: #ffffff; text-decoration-thickness: initial; text-decoration-style:=
 initial; text-decoration-color: initial;"><br data-mce-bogus=3D"1"></p><p =
style=3D"margin: 0px; padding: 0px; color: rgb(23, 43, 77); font-family: -a=
pple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubun=
tu, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quo=
t;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures=
: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: norm=
al; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: =
normal; background-color: rgb(255, 255, 255); text-decoration-thickness: in=
itial; text-decoration-style: initial; text-decoration-color: initial;" dat=
a-mce-style=3D"margin: 0px; padding: 0px; color: #172b4d; font-family: -app=
le-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sa=
ns', 'Droid Sans', 'Helvetica Neue', sans-serif; font-size: 14px; font-styl=
e: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-=
weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-in=
dent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text=
-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-de=
coration-thickness: initial; text-decoration-style: initial; text-decoratio=
n-color: initial;">Attached is a test program that demonstrates the problem=
. We used a few different USB-to-Serial adapters with no driver installed a=
s a convenient way to reproduce. We check the TRB debug information before =
and after to verify the actual number of allocated TRBs.</p><p style=3D"mar=
gin: 0px; padding: 0px; color: rgb(23, 43, 77); font-family: -apple-system,=
 BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, &quot;Fi=
ra Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-ser=
if; font-size: 14px; font-style: normal; font-variant-ligatures: normal; fo=
nt-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans:=
 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; w=
ord-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; back=
ground-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-=
decoration-style: initial; text-decoration-color: initial;" data-mce-style=
=3D"margin: 0px; padding: 0px; color: #172b4d; font-family: -apple-system, =
BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans', 'Droid=
 Sans', 'Helvetica Neue', sans-serif; font-size: 14px; font-style: normal; =
font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400=
; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-wid=
th: 0px; white-space: normal; background-color: #ffffff; text-decoration-th=
ickness: initial; text-decoration-style: initial; text-decoration-color: in=
itial;"><br data-mce-bogus=3D"1"></p><p style=3D"margin: 0px; padding: 0px;=
 color: rgb(23, 43, 77); font-family: -apple-system, BlinkMacSystemFont, &q=
uot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, &quot;Fira Sans&quot;, &quot;Dr=
oid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14px; fo=
nt-style: normal; font-variant-ligatures: normal; font-variant-caps: normal=
; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webk=
it-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, =
255, 255); text-decoration-thickness: initial; text-decoration-style: initi=
al; text-decoration-color: initial;" data-mce-style=3D"margin: 0px; padding=
: 0px; color: #172b4d; font-family: -apple-system, BlinkMacSystemFont, 'Seg=
oe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'Helvetica Neue'=
, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal=
; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; wi=
dows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: no=
rmal; background-color: #ffffff; text-decoration-thickness: initial; text-d=
ecoration-style: initial; text-decoration-color: initial;">With some adapte=
rs on unaffected kernels, the TRB map gets expanded correctly. This directl=
y corresponds to correct functional behavior. On affected kernels, the TRB =
ring does not expand, and our functional tests also will fail.</p><p style=
=3D"margin: 0px; padding: 0px; color: rgb(23, 43, 77); font-family: -apple-=
system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, &=
quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, s=
ans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: nor=
mal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; o=
rphans: 2; text-align: start; text-indent: 0px; text-transform: none; widow=
s: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: norma=
l; background-color: rgb(255, 255, 255); text-decoration-thickness: initial=
; text-decoration-style: initial; text-decoration-color: initial;" data-mce=
-style=3D"margin: 0px; padding: 0px; color: #172b4d; font-family: -apple-sy=
stem, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans', =
'Droid Sans', 'Helvetica Neue', sans-serif; font-size: 14px; font-style: no=
rmal; font-variant-ligatures: normal; font-variant-caps: normal; font-weigh=
t: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent:=
 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stro=
ke-width: 0px; white-space: normal; background-color: #ffffff; text-decorat=
ion-thickness: initial; text-decoration-style: initial; text-decoration-col=
or: initial;"><br data-mce-bogus=3D"1"></p><p style=3D"margin: 0px; padding=
: 0px; color: rgb(23, 43, 77); font-family: -apple-system, BlinkMacSystemFo=
nt, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, &quot;Fira Sans&quot;, &q=
uot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14=
px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: s=
tart; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px;=
 -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb=
(255, 255, 255); text-decoration-thickness: initial; text-decoration-style:=
 initial; text-decoration-color: initial;" data-mce-style=3D"margin: 0px; p=
adding: 0px; color: #172b4d; font-family: -apple-system, BlinkMacSystemFont=
, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'Helvetica=
 Neue', sans-serif; font-size: 14px; font-style: normal; font-variant-ligat=
ures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: no=
ne; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-spa=
ce: normal; background-color: #ffffff; text-decoration-thickness: initial; =
text-decoration-style: initial; text-decoration-color: initial;">We don't k=
now exactly why this happens. Some adapters do work correctly, so there see=
ms to also be some subtle problem that was being masked by the liberal expa=
nsion of the TRB ring in older kernels. We also saw on one system that the =
TRB expansion did work correctly with one particular adapter. However, on a=
ll systems at least two adapters did exhibit the problem and fail.</p><p st=
yle=3D"margin: 0px; padding: 0px; color: rgb(23, 43, 77); font-family: -app=
le-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu=
, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;=
, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal=
; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; wi=
dows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: no=
rmal; background-color: rgb(255, 255, 255); text-decoration-thickness: init=
ial; text-decoration-style: initial; text-decoration-color: initial;" data-=
mce-style=3D"margin: 0px; padding: 0px; color: #172b4d; font-family: -apple=
-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans=
', 'Droid Sans', 'Helvetica Neue', sans-serif; font-size: 14px; font-style:=
 normal; font-variant-ligatures: normal; font-variant-caps: normal; font-we=
ight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-inde=
nt: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-s=
troke-width: 0px; white-space: normal; background-color: #ffffff; text-deco=
ration-thickness: initial; text-decoration-style: initial; text-decoration-=
color: initial;"><br data-mce-bogus=3D"1"></p><p style=3D"margin: 0px; padd=
ing: 0px; color: rgb(23, 43, 77); font-family: -apple-system, BlinkMacSyste=
mFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, &quot;Fira Sans&quot;,=
 &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif; font-size:=
 14px; font-style: normal; font-variant-ligatures: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align=
: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: =
rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-sty=
le: initial; text-decoration-color: initial;" data-mce-style=3D"margin: 0px=
; padding: 0px; color: #172b4d; font-family: -apple-system, BlinkMacSystemF=
ont, 'Segoe UI', Roboto, Oxygen, Ubuntu, 'Fira Sans', 'Droid Sans', 'Helvet=
ica Neue', sans-serif; font-size: 14px; font-style: normal; font-variant-li=
gatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform:=
 none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-=
space: normal; background-color: #ffffff; text-decoration-thickness: initia=
l; text-decoration-style: initial; text-decoration-color: initial;">Would i=
t be possible to resolve this regression for the 6.8 release and backport t=
he fix to versions 6.5, 6.6, and 6.7?</p></div><div><br data-mce-bogus=3D"1=
"></div><div>#regzbot ^introduced: <span style=3D"white-space: normal;">f5a=
f638f0609af889f15c700c60b93c06cc76675</span></div></div></body></html>
--=_30356fbf-110c-4a07-a24b-a445a01b25e1--

------=_Part_833958_1937603355.1709339266737
Content-Type: text/x-csrc; name=xhci_bug.c
Content-Disposition: attachment; filename=xhci_bug.c
Content-Transfer-Encoding: base64

Ly8gVGVzdCBjYXNlIGZvciBYSENJIGJ1ZmZlciBleHBhbnNpb24gcmVncmVzc2lvbgovLwovLyAx
KSBDb21waWxlIHRoaXMgcHJvZ3JhbTogIGdjYyAtbyB4aGNpX2J1ZyB4aGNpX2J1Zy5jCi8vIDIp
IFBsdWcgaW4gYSBzdXBwb3J0ZWQgVVNCIHRvIHNlcmlhbCBkZXZpY2UKLy8gMykgR2V0IHRoZSBi
dXMgYW5kIGRldmljZSBudW1iZXJzIGZyb20gbHN1c2I6Ci8vICAgIEJ1cyAwMDMgRGV2aWNlIDAx
NTogSUQgMDQwMzo2MDAxIEZ1dHVyZSBUZWNobm9sb2d5IERldmljZXMgSW50ZXJuYXRpb25hbCwg
THRkIEZUMjMyIFNlcmlhbCAoVUFSVCkgSUMKLy8gNCkgUnVuIGFzIHJvb3Q6ICAuL3hoY2lfYnVn
IGZ0ZGlfc2lvIDMgMTUgNDA5NgoKI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5o
PgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5n
Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgojaW5jbHVkZSA8
bGludXgvdXNiZGV2aWNlX2ZzLmg+CgojZGVmaW5lIFVSQl9TSVpFIDY0CgpzdHJ1Y3QgRGV2aWNl
IHsKICAgIGNvbnN0IGNoYXIgKmRyaXZlcjsKICAgIGludCAgICAgICAgIGVwOwogICAgY29uc3Qg
Y2hhciAqZXBfZGVidWc7Cn07CgpzdGF0aWMgc3RydWN0IERldmljZSBkZXZpY2VzW10gPSB7CiAg
ICB7ICJmdGRpX3NpbyIsIDB4ODEsICJlcDAyIiB9LAogICAgeyAicGwyMzAzIiwgICAweDgzLCAi
ZXAwNiIgfSwKICAgIHsgImNwMjEweCIsICAgMHg4MiwgImVwMDQiIH0sCiAgICB7IH0sCn07Cgpp
bnQgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewogICAgLy8gUGFyc2UgY29tbWFuZCBs
aW5lCiAgICBpZiAoYXJnYyA8IDQpIHsKICAgICAgICBjaGFyIGRyaXZlcnNbMjU1XSA9IHsgfTsK
ICAgICAgICBmb3IgKGludCBpID0gMDsgZGV2aWNlc1tpXS5kcml2ZXI7ICsraSkgewogICAgICAg
ICAgICBzdHJjYXQoZHJpdmVycywgZGV2aWNlc1tpXS5kcml2ZXIpOwogICAgICAgICAgICBpZiAo
ZGV2aWNlc1tpKzFdLmRyaXZlcikgc3RyY2F0KGRyaXZlcnMsICJ8Iik7CiAgICAgICAgfQoKICAg
ICAgICBwcmludGYoInVzYWdlOiB4aGNpX2J1ZyA8JXM+IEJVUyBERVYgTlVNX1VSQlNcbiIsIGRy
aXZlcnMpOwogICAgICAgIHJldHVybiAxOwogICAgfQoKICAgIGNvbnN0IGNoYXIgKmRyaXZlciA9
IGFyZ3ZbMV07CiAgICBpbnQgYnVzID0gYXRvaShhcmd2WzJdKTsKICAgIGludCBkZXYgPSBhdG9p
KGFyZ3ZbM10pOwogICAgaW50IG51bV91cmJzID0gYXRvaShhcmd2WzRdKTsKCiAgICBpZiAobnVt
X3VyYnMgPiA0MDk2KQogICAgICAgIG51bV91cmJzID0gNDA5NjsKCiAgICAvLyBGaW5kIHRoZSBk
cml2ZXIKICAgIHN0cnVjdCBEZXZpY2UgKmRldmljZSA9IE5VTEw7CiAgICBmb3IgKGludCBpID0g
MDsgZGV2aWNlc1tpXS5kcml2ZXI7ICsraSkgewogICAgICAgIGlmIChzdHJjbXAoZGV2aWNlc1tp
XS5kcml2ZXIsIGRyaXZlcikgPT0gMCkgewogICAgICAgICAgICBkZXZpY2UgPSAmZGV2aWNlc1tp
XTsKICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgfQogICAgfQoKICAgIGlmIChkZXZpY2UgPT0g
TlVMTCkgewogICAgICAgIHByaW50ZigiZXJyb3I6IGRyaXZlciAlcyBub3QgZm91bmRcbiIsIGRy
aXZlcik7CiAgICAgICAgcmV0dXJuIDE7CiAgICB9CgogICAgLy8gUmVtb3ZlIHRoZSBkcml2ZXIK
ICAgIGNoYXIgY21kWzEwMjRdOwogICAgc3ByaW50ZihjbWQsICJsc21vZCB8IGdyZXAgJXMgLXEg
JiYgcm1tb2QgJXMiLCBkcml2ZXIsIGRyaXZlcik7CiAgICBzeXN0ZW0oY21kKTsKCiAgICAvLyBH
ZXQgdGhlIGRlYnVnIHBhdGgKICAgIGNoYXIgZGVidWdbMjU2XSA9IHsgfTsKCiAgICBzcHJpbnRm
KAogICAgICAgIGNtZCwKICAgICAgICAiZmluZCAvc3lzL2tlcm5lbC9kZWJ1Zy91c2IveGhjaSAt
bmFtZSAnbmFtZScgfCAiCiAgICAgICAgIndoaWxlIElGUz0gcmVhZCAtciBsaW5lOyBkbyAiCiAg
ICAgICAgImRpcj0kKGRpcm5hbWUgJGxpbmUpOyAiCiAgICAgICAgInN5cz0vc3lzL2J1cy91c2Iv
ZGV2aWNlcy8kKGNhdCAkZGlyL25hbWUpOyAiCiAgICAgICAgImdyZXAgLXEgJ14lZCQnICRzeXMv
YnVzbnVtICYmICIKICAgICAgICAiZ3JlcCAtcSAnXiVkJCcgJHN5cy9kZXZudW0gJiYgIgogICAg
ICAgICJlY2hvICRkaXI7ICIKICAgICAgICAiZG9uZSIsCiAgICAgICAgYnVzLCBkZXYKICAgICk7
CgogICAgRklMRSAqZnAgPSBwb3BlbihjbWQsICJyIik7CiAgICBjaGFyICpwID0gZmdldHMoZGVi
dWcsIHNpemVvZihkZWJ1ZyksIGZwKTsKICAgIHBjbG9zZShmcCk7CgogICAgaWYgKHAgPT0gTlVM
TCkgewogICAgICAgIHByaW50ZigiZXJyb3I6IGRlYnVnIHBhdGggbm90IGZvdW5kXG4iKTsKICAg
ICAgICByZXR1cm4gMTsKICAgIH0KCiAgICBkZWJ1Z1tzdHJsZW4oZGVidWcpLTFdID0gJ1wwJzsK
CiAgICAvLyBQcmludCB0aGUgbnVtYmVyIG9mIFRSQnMKICAgIHByaW50ZigiQmVmb3JlIFVSQiBz
dWJtaXNzaW9uOlxuIik7CiAgICBzcHJpbnRmKGNtZCwgIndjIC1sICVzLyVzL3RyYnMiLCBkZWJ1
ZywgZGV2aWNlLT5lcF9kZWJ1Zyk7CiAgICBzeXN0ZW0oY21kKTsKICAgIHByaW50ZigiXG4iKTsK
CiAgICAvLyBPcGVuIHRoZSBkZXZpY2UKICAgIGNoYXIgcGF0aFsyNTZdOwogICAgc3ByaW50Zihw
YXRoLCAiL2Rldi9idXMvdXNiLyUwM2QvJTAzZCIsIGJ1cywgZGV2KTsKCiAgICBpbnQgZmQgPSBv
cGVuKHBhdGgsIE9fUkRXUik7CiAgICBpZiAoZmQgPCAwKQogICAgICAgIHJldHVybiAxOwoKICAg
IGludCByYzsKCiAgICBpbnQgY2ZnID0gMTsKICAgIHJjID0gaW9jdGwoZmQsIFVTQkRFVkZTX1NF
VENPTkZJR1VSQVRJT04sICZjZmcpOwogICAgaWYgKHJjIDwgMCAmJiBlcnJubyAhPSBFQlVTWSkg
ewogICAgICAgIHByaW50ZigiZXJyb3I6IHVuYWJsZSB0byBzZXQgY29uZmlndXJhdGlvblxuIik7
CiAgICAgICAgY2xvc2UoZmQpOwogICAgICAgIHJldHVybiAxOwogICAgfQoKICAgIGludCBpZmNl
ID0gMDsKICAgIHJjID0gaW9jdGwoZmQsIFVTQkRFVkZTX0NMQUlNSU5URVJGQUNFLCAmaWZjZSk7
CiAgICBpZiAocmMgPCAwKSB7CiAgICAgICAgcHJpbnRmKCJlcnJvcjogdW5hYmxlIHRvIGNsYWlt
IGludGVyZmFjZVxuIik7CiAgICAgICAgY2xvc2UoZmQpOwogICAgICAgIHJldHVybiAxOwogICAg
fQoKICAgIC8vIFN1Ym1pdCBVUkJzCiAgICBwcmludGYoIlN1Ym1pdHRpbmcgJWQgVVJCc1xuXG4i
LCBudW1fdXJicyk7CgogICAgZm9yIChpbnQgaSA9IDA7IGkgPCBudW1fdXJiczsgKytpKSB7CiAg
ICAgICAgc3RydWN0IHVzYmRldmZzX3VyYiAqaW9jdGxfdXJiID0gY2FsbG9jKDEsIHNpemVvZigq
aW9jdGxfdXJiKSk7CgogICAgICAgIGlvY3RsX3VyYi0+dHlwZSAgICAgICAgICA9IFVTQkRFVkZT
X1VSQl9UWVBFX0JVTEs7CiAgICAgICAgaW9jdGxfdXJiLT5lbmRwb2ludCAgICAgID0gZGV2aWNl
LT5lcDsKICAgICAgICBpb2N0bF91cmItPmJ1ZmZlciAgICAgICAgPSBjYWxsb2MoMSwgVVJCX1NJ
WkUpOwogICAgICAgIGlvY3RsX3VyYi0+YnVmZmVyX2xlbmd0aCA9IFVSQl9TSVpFOwoKICAgICAg
ICByYyA9IGlvY3RsKGZkLCBVU0JERVZGU19TVUJNSVRVUkIsIGlvY3RsX3VyYik7CiAgICAgICAg
aWYgKHJjIDwgMCkgewogICAgICAgICAgICBwcmludGYoImVycm9yOiBjb3VsZCBub3Qgc3VibWl0
IHVyYiAjJWRcbiIsIGkpOwogICAgICAgICAgICByZXR1cm4gMTsKICAgICAgICB9CiAgICB9Cgog
ICAgLy8gUHJpbnQgdGhlIG51bWJlciBvZiBUUkJzCiAgICBwcmludGYoIkFmdGVyIFVSQiBzdWJt
aXNzaW9uOlxuIik7CiAgICBzeXN0ZW0oY21kKTsKICAgIHByaW50ZigiXG4iKTsKCiAgICAvLyBD
bG9zZSB0aGUgZGV2aWNlCiAgICBjbG9zZShmZCk7CiAgICByZXR1cm4gMDsKfQo=
------=_Part_833958_1937603355.1709339266737--

