Return-Path: <stable+bounces-67696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D64695220A
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A4C1F23BF8
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E491BD514;
	Wed, 14 Aug 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0oxLgeCi"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249401B0111
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660139; cv=none; b=igriexqDzPtLEpdnSlUxWagNPirL66YIG2ns7jVzeIZ+Lc+EAKAX7oQ/cVXuMlqwtpXzKFQQKKshMgVKMYE6S3GnDdX3XTDV1TMsCMABb3qz0l6NNhEP99m2bDslheMV5sJYQSqM7FGrcFVHwZsuMfCMdGQTvI9a+rtAdTiw7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660139; c=relaxed/simple;
	bh=LaVKcWRKchzap3BA0Pp1ih4MlQWJRwjI99o+pv+IRfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phXqRgFPleOxduhhFOWmFgq7+7/DaNF9CDS/GRrO7L7sZMu0WRcBRjtwQFI1BeMUUZE/pBQ5r+cHrrrSZgBABvSweHHwcuGdn5+pMGE6xCgiX3rfNww9LuLfE+FeqHkdCuN4PjVqw99c+2ITIoLESTygNHdcxdVjBTKCh7SwVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0oxLgeCi; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WkcGJ1vvHz6ClbJ9;
	Wed, 14 Aug 2024 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1723660133; x=1726252134; bh=gx1bGuHcMZdgKgL5krtv/f2vas2K+Xuo2K3
	4xtJzSyc=; b=0oxLgeCiAG3UyQKD9CKfM3bC6a7riQgmfF2M81OoRUwtYLaWhg2
	8KUdp1u/6YMyRELhEui1TOUB2WEAjM60U8+B04HZt8jPl2Ne09goMmf9DW12ynp4
	UYZ8qwoWVtQZQ1Yy8nY0Usmw8XllVxig4FQ73Goby2mlNcMxrbehOeq+YIzZnZlA
	d4g+YmeDvRbS2kN7sNJIJcUgOnQYEan+bzzfUKqEJ5sqj6CaC3QWt5uid6ty0UMZ
	pnKD+wO/IBBlkQz3HmLYVm1c4w2yKLgIVhnD3wiXyRXpH0FZ71GRQejeml+ya4+l
	4+4nWGNWKDS2JNYjIMW1jPcFMOWgFYwaUHA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CZBk9QGHKZSx; Wed, 14 Aug 2024 18:28:53 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WkcGF061Sz6CmLxT;
	Wed, 14 Aug 2024 18:28:52 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Stevens <stevensd@chromium.org>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	stable@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 6.6 0/2] Two patches related to CPU hotplugging
Date: Wed, 14 Aug 2024 11:28:24 -0700
Message-ID: <20240814182826.1731442-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Please consider these two patches for the 6.6 kernel. These patches are
unmodified versions of the corresponding upstream commits.

Thank you,

Bart.

David Stevens (1):
  genirq/cpuhotplug: Skip suspended interrupts when restoring affinity

Dongli Zhang (1):
  genirq/cpuhotplug: Retry with cpu_online_mask when migration fails

 kernel/irq/cpuhotplug.c | 27 ++++++++++++++++++++++++---
 kernel/irq/manage.c     | 12 ++++++++----
 2 files changed, 32 insertions(+), 7 deletions(-)


