Return-Path: <stable+bounces-166793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF52DB1DAD8
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5D01AA330C
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C40D26A0A0;
	Thu,  7 Aug 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plan9.rocks header.i=@plan9.rocks header.b="m0i2kCQG"
X-Original-To: stable@vger.kernel.org
Received: from plan9.rocks (vmi607075.contaboserver.net [207.244.235.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF325EF87
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.244.235.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580683; cv=none; b=hXHTbB2/+9oTFQceMArpEIiYcrzE8AETTD9Kk60niwKar7fF1yG5HWyXfxiymKZ0t2wUHA/24HUYwC2chYxqmktVDwo3IrvoMKvk/pNzEIUSx2RGLhG4lYxl9J0RgONO+4M46/bDJzyt8uc77HjOyz5tWj+n325bIsECtLMuY50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580683; c=relaxed/simple;
	bh=4X8DBA0OR7oKbaoqpKdZjYvb44r6seT/lZ1WfoKnjZA=;
	h=Date:From:CC:Subject:Message-ID:MIME-Version:Content-Type; b=Mq8dqsyDb723aMVKeg1kWtaJSGtcG+4t8y4MkJPzPtsqkHQidg3h0/ha8P0B+8eEYpgXN1SQ3bG78OMLrcqFaJC0iZi+nbu2f/D78NFK3tTZQE5PJOyvLczHj4M16mmAq39wxFwV9fBfF/YtII5zz65xoJou2XayDhgOSt6/zu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plan9.rocks; spf=pass smtp.mailfrom=plan9.rocks; dkim=pass (2048-bit key) header.d=plan9.rocks header.i=@plan9.rocks header.b=m0i2kCQG; arc=none smtp.client-ip=207.244.235.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plan9.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plan9.rocks
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=plan9.rocks; s=mail;
	t=1754580680; bh=4X8DBA0OR7oKbaoqpKdZjYvb44r6seT/lZ1WfoKnjZA=;
	h=Date:From:CC:Subject:From;
	b=m0i2kCQGLr8Qw3np8LiXySjEBwnk0dP7bBwnHz/8rkfQ6K4fdwqJ4Ek7lscFXC1Vj
	 2RKTzsuuHqdVgIoPS4Sn0UmzbL/wZW0ImpSK1zNrv5ybSwvlKio5AtgzadHB32pARX
	 eIjDaxNYif2VhAZKAEMP30QnLSSjNd4Wcdwzq1mKtFpnaQFe2py+gY0Yt5jR1Nb5jY
	 PeehXuoTjVYa8FOQNVzy1OydwrQX3aHvhbfiEjq6Qr+mhAzq+wC0qxVhGaz/gvF6XN
	 EfAUD7CPy4zRyWCR2/D4zLkhdobsWfJRhMM9s32MOHfBKiSfkzu9liZXV3lO0/A9jn
	 SjxcJMKYKS5Nw==
Received: from [127.0.0.1] (unknown [138.199.6.237])
	by plan9.rocks (Postfix) with ESMTPSA id AC2CC12007B0;
	Thu,  7 Aug 2025 10:31:19 -0500 (CDT)
Date: Thu, 07 Aug 2025 15:31:17 +0000
From: cat <cat@plan9.rocks>
CC: regressions@lists.linux.dev, stable@vger.kernel.org
Subject: [REGRESSION] vfio gpu passthrough stopped working
User-Agent: K-9 Mail for Android
Message-ID: <718C209F-22BD-4AF3-9B6F-E87E98B5239E@plan9.rocks>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

#regzbot introduced: v6=2E12=2E34=2E=2Ev6=2E12=2E35

After upgrade to kernel 6=2E12=2E35, vfio passthrough for my GPU has stopp=
ed working within a windows VM, it sees device in device manager but report=
s that it did not start correctly=2E I compared lspci logs in the vm before=
 and after upgrade to 6=2E12=2E35, and here are the changes I noticed:

- the reported link speed for the passthrough GPU has changed from 2=2E5 t=
o 16GT/s
- the passthrough GPU has lost it's 'BusMaster' and MSI enable flags
- latency measurement feature appeared

These entries also began appearing within the vm in dmesg when host kernel=
 is 6=2E12=2E35 or above:

[    1=2E963177] nouveau 0000:01:00=2E0: sec2(gsp): mbox 1c503000 00000001
[    1=2E963296] nouveau 0000:01:00=2E0: sec2(gsp):booter-load: boot faile=
d: -5
=2E=2E=2E
[    1=2E964580] nouveau 0000:01:00=2E0: gsp: init failed, -5
[    1=2E964641] nouveau 0000:01:00=2E0: init failed with -5
[    1=2E964681] nouveau: drm:00000000:00000080: init failed with -5
[    1=2E964721] nouveau 0000:01:00=2E0: drm: Device allocation failed: -5
[    1=2E966318] nouveau 0000:01:00=2E0: probe with driver nouveau failed =
with error -5


6=2E12=2E34 worked fine, and latest 6=2E12 LTS does not work either=2E I a=
m using intel CPU and nvidia GPU (for passthrough, and as my GPU on linux s=
ystem)=2E

