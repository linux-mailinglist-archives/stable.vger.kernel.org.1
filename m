Return-Path: <stable+bounces-76552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E151F97AC0D
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 09:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0428A1C20FAE
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 07:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362701482E2;
	Tue, 17 Sep 2024 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Pa69DZwm"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D00E44C77;
	Tue, 17 Sep 2024 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558155; cv=none; b=lBwqxmsJcZY/njgFDESuKWH8911PMlXmxVys9eIDNBlI+6neXjkHoYrEToJFdnp2xC89jrbpI0iZf8VUhmjU0Oq0V5Po2TBDpQDvmy4W5p9QE61P0gcfqc7RGspE23eNwv4bDHr977PbMaotzB/VQfysMiobEa0R1seH/Hn9iyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558155; c=relaxed/simple;
	bh=VCMoz0pfiXITvmkI13i26DbCBRGs50uyhJjWCgV/eW4=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=c8XZ9KA/eiYEcZnRrtbf/WUJWqpDc/5czGJ4l6T0bwl64HzkcDNVO8zZG2yCJccTLDkPuF45RFXJAhaBLW4fK2Tr81SiKdbgqNan/8ciMBCm0jqhJIisS7h4GukrdNa39Sv7TZ6AleKFZCwf65iinqFD42Ba1O9/eR2LTqPuTkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Pa69DZwm; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:From:Mime-Version:Subject:Message-Id:
	Date; bh=VCMoz0pfiXITvmkI13i26DbCBRGs50uyhJjWCgV/eW4=; b=Pa69DZw
	m1ZSqb+Rgb0L5a435iss0G4wVvavD4a+Vs3aQ6ziwJL6cqzKdHJBRMreXXg4XhDL
	fMWB6mP+r2QGi4BLQ7P1r7RXcc8uYzvyN3+BMHU27TN8f1UQv0mo5uvAUTQF9rQb
	eZgEXVzgOUS5rGQoOTg68K4hwjaVg9DYU2ns=
Received: from smtpclient.apple (unknown [39.144.238.104])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDXH86wL+lmr6HVBQ--.38819S2;
	Tue, 17 Sep 2024 15:28:48 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Qianqiang Liu <qianqiang.liu@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: [PATCH] fbcon: Fix a NULL pointer dereference issue in fbcon_putcs
Message-Id: <578C92EE-A2B2-4611-BDBD-E33EB6CAB046@163.com>
Date: Tue, 17 Sep 2024 15:28:37 +0800
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
To: Helge Deller <deller@gmx.de>
X-Mailer: iPhone Mail (21H16)
X-CM-TRANSID:_____wDXH86wL+lmr6HVBQ--.38819S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUvmiiUUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYBRdamV4JTLP7gAAso

=EF=BB=BF
> I think this patch just hides the real problem.
> How could putcs have become NULL ?
>=20
> Helge

Oh, you are right!
I will figure it out.

Best,
Qianqiang Liu


