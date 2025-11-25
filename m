Return-Path: <stable+bounces-196918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF59C85BFB
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 16:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4907B3AF9D8
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B67328251;
	Tue, 25 Nov 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMUzYo5e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFCB327C1A
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084198; cv=none; b=EQEVOjCU+dIXEb4Nb9u2xjV3W5YmOkTEuRc7MLIg8mU2SoW6r041UslIzBMLWUrGpwk4R6UWk4DtvfJxYnYv5+xRrZEj8ikEVec9i6bY+xRrjUtLmMmmuTcagnw7nxGmDKPqDJr5s9yid9Wq/tcEUg9YxUchgmJP5xZuHlkNnZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084198; c=relaxed/simple;
	bh=HKUuU+leqsVudzeFU3VFYRNamAHxyt8yy2yHJzQ8iLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWedNHvrQQ0PU25w/fMPTkU7e2xQ2ti1bQJ4MDDPsBcTAHnIe2eYOUKgbsLwkUZS4LSPOUcWXTnW012CcChERdcZaRom6Xh0cNsIdYA5CSerjZi/Vyw5LwOdQgLAplrWwysDq9yss7e+KZaU23tK6XKkghuu63oaXcx71kNwbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMUzYo5e; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c7869704so4740877f8f.2
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764084194; x=1764688994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX7n82CXAITT0MrjRDw7p4gxGQsnPKQT76h2mkMbJMw=;
        b=lMUzYo5e8I0acM4xjTBSXwU/EHENKbgwquq3HmsVMdpy5gECgJTPB/muK4INoSMItW
         bcxGwKk65M9RVltCud78u0w/LH3hNRB7IbueFUzVOjsQ1SCNf3qyuJv+FMpZ9t2b5OLx
         4wH9kLIK8MF2NZ38lkL83DKQD03s6qxteiuZoeCj59DQtUe6VaNdkIeA4n37OgaQaDlh
         X2bz6z+LQcFMANXivR0lG4jNst223t9rhaW2HkIiBQTR/K4jxlmAtm0yCmCKgsvRhW+s
         3xsO41wpJPcuLlYbFNfNuO+VoOvtKfSOQA6WmtFaW8puzlJ8F/ussMC4g/q50rWWVK+/
         H/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764084194; x=1764688994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TX7n82CXAITT0MrjRDw7p4gxGQsnPKQT76h2mkMbJMw=;
        b=fVSKa9JgPtpxFl8hj+xjdML7m9oGvr+XU49lk6AXPDhuiotQOZkgZ702Ap9Ud2yRXy
         OMFoLyOTyYAVFNpK4SfMo3+0b+UJVtMCwaupGkpZ6fG0TTOBgSLsYIRNOWj5C5kDhqOF
         a4ezTh9ilezVNSTgEw/p4hu9UUNk/X6moULoos9r27aT2TlwFVDK0vtKlPixvz5zkmpV
         oEPzh4ttjrzAr6ZgYbVBVn9p5N1fgCvMy86sj7S5alvod0JpuTt4TuS3jWVUBEkywLLM
         ffAatlP3zHmX7vIPohz1+0axO7rrsL5sF8PeJ6S8fLBdeieZizKU7cAb9CHQiYgbmzF0
         nrwA==
X-Forwarded-Encrypted: i=1; AJvYcCWjo+ZPLRa/b9FwRw57Fsug3oGBd5PsRuyddmFffs78Td/LZ1dM85kJPa4LTy8oI3latbVnXhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+sP6ZmSpgKvU42jDuzi1DVd+mo6G3ACQi1rje1fcQUiNJqdy
	HYvgabjiv9nXHdyQhQC3vSxmrGORgWQdJOZqMHnWZSixUVa+VY1kpRMS
X-Gm-Gg: ASbGncsmQgBo4kOxhrb2xyQpZVm0rsNMSdopdcLKc3bVd8jzoxWuyqtrme1w00LEYQA
	M76PobpzJO+mhlelx1qUuMYDu5/LNTFI8iEWVTH/2UI17GLHpBk1HfLkOx7f3DvqeJmblBQroVO
	rHvXcyc+gTP56DPsMzLRa2fls1zxVC0bEfVDqk2poOHy2pvegZeZ7omrXlaoLrlNsZFfmUNB4Oe
	1+3QzVvGrj4ihGbeEHYq6Nq/7eP+lqbggATFVZA1aguW5VYirpXEfR6I4C67jM216VASgZoHB3H
	m/t5s3DM9bPgGo0OB79inYVNAliiiw0wRQzsJaXoymEzV5qb5vZRX3lU7SKEtODrUHfd+rvnjLT
	BGP/ZgSpyzUXK58oBxidW2hQj+Qg3b++enER2qxp4fMvpVgF4G2lSLx1OrL3J9uT4OVKDEU85lf
	32UOHXP92kd7zcD3QDlpyNpgVNPNUHUJt6vw0CmFpk2umvKimcFdawvL+6a2DC1bRfxNSRUiJ9V
	uW3kCsFNP+RHrxE
X-Google-Smtp-Source: AGHT+IFXA3qVhii3HjcFe+XIGNd+u9teq4CV8hAleQ1XsRKil5xBAkHJxKVhrQynFv+TMPu0obMr4Q==
X-Received: by 2002:a05:6000:1a8b:b0:427:23a:c339 with SMTP id ffacd0b85a97d-42e0f20434cmr3649980f8f.14.1764084193959;
        Tue, 25 Nov 2025 07:23:13 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8d97sm34397911f8f.42.2025.11.25.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:23:13 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	Fabio Porcedda <Fabio.Porcedda@telit.com>,
	stable@vger.kernel.org,
	Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH 1/2] USB: serial: option: add Telit Cinterion FE910C04 new compositions
Date: Tue, 25 Nov 2025 16:22:36 +0100
Message-ID: <bd3d3e3922e792b339c147717dc3473d92c4de40.1764083851.git.fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764083851.git.fabio.porcedda@gmail.com>
References: <cover.1764083851.git.fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Porcedda <Fabio.Porcedda@telit.com>

Add the following Telit Cinterion new compositions:

0x10c1: RNDIS + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c1 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c2: MBIM + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c2 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c3: ECM + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  9 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c3 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c5: RNDIS + tty (AT) + tty (AT) + tty (diag)
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c5 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c6: MBIM + tty (AT) + tty (AT) + tty (diag)
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 11 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c6 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c9: MBIM + tty (AT) + tty (diag) + DPL (Data Packet Logging) + adb
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 13 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c9 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10cb: RNDIS + tty (AT) + tty (diag) + DPL (Data Packet Logging) + adb
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh=16
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev=06.18
S:  Manufacturer=Linux 6.18.0-rc3-usb+ xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=01 Lev=01 Prnt=01 Port=11 Cnt=01 Dev#=  7 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=413c ProdID=2003 Rev=03.01
S:  Manufacturer=Dell
S:  Product=Dell USB Keyboard
C:  #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=70mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=24ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=10000 MxCh=10
D:  Ver= 3.10 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
P:  Vendor=1d6b ProdID=0003 Rev=06.18
S:  Manufacturer=Linux 6.18.0-rc3-usb+ xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/usb/serial/option.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index e9400727ad36..b9983e6f5eff 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1433,10 +1433,24 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b3, 0xff, 0xff, 0x60) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c0, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c1, 0xff),	/* Telit FE910C04 (RNDIS) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c2, 0xff),	/* Telit FE910C04 (MBIM) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c3, 0xff),	/* Telit FE910C04 (ECM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c4, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c5, 0xff),	/* Telit FE910C04 (RNDIS) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c6, 0xff),	/* Telit FE910C04 (MBIM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c8, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c9, 0xff),	/* Telit FE910C04 (MBIM) */
+	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10cb, 0xff),	/* Telit FE910C04 (RNDIS) */
+	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x30),	/* Telit FN990B (rmnet) */
 	  .driver_info = NCTRL(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x40) },
-- 
2.52.0


