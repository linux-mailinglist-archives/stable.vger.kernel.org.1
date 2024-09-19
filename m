Return-Path: <stable+bounces-76779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A997CE4F
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 21:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6C91F23D15
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 19:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42B131BDF;
	Thu, 19 Sep 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="NTS7pqOo"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631B139CFA
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775830; cv=none; b=lIlFzg8YvZy+iE47qgyZEtocgpIi10WtG/7XGi0aCeOJ5b2AofpQF7DbhrX7lFU4GFE6y3ACXOD7un0wfT7RNuSwpUC9d3XvJ7/n/L9qkZehZ7jFM6Hr3F554ZubghDj377ry7ossv5Fwo/QLl2Lm/p5bGRdjn4XNgxPI/tsOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775830; c=relaxed/simple;
	bh=a9BxBT1wCsc64mDbrrLB8LyO97F4nWvsqQxh7Vxni3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RErSeoXFEDmbX5rytmh+UyeGlmSwXH+vfeK6XRqFCJZEW+bPS5u9pdxrayW5n2eAh1ioT+8E6gUF3OC4AQG4essct0Ll0+Uijzu0Y17htVnis33Sn7b9WSqbEwZeDnMkxh4xbMs8yXrqT69/SHB9Kx7mXbrjmOBbMS93+IxD2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=NTS7pqOo; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Andrey Kalachev <kalachev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1726775818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a9BxBT1wCsc64mDbrrLB8LyO97F4nWvsqQxh7Vxni3Y=;
	b=NTS7pqOo+GX7RZNv0VJIMCBX+5Cxu3yBEfxtLcPd/fhmVNFFn6NJPLvSVfmGwXKbMANGsi
	9hVfYcuKAEGQI7yCzP6pqEhXqI/+nXF8XmfmkCHw8U0Y1CDpKuOeyK9nLTo12RnHV0Q5OO
	6ObKp6tTu0tl0hgb4J7fXhonsyY4neI=
To: stable@vger.kernel.org
Cc: Andrey Kalachev <kalachev@swemel.ru>,
	lvc-project@linuxtesting.org,
	dchinner@redhat.com,
	hch@lst.de,
	djwong@kernel.org,
	syzbot+66f256de193ab682584f@syzkaller.appspotmail.com,
	syzbot+904ffc7f25c759741787@syzkaller.appspotmail.com
Subject: syzbot: KASAN: slab-out-of-bounds Read in xlog_pack_data
Date: Thu, 19 Sep 2024 22:56:20 +0300
Message-Id: <20240919195623.27624-1-kalachev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I found that the syzbot bug 'KASAN: slab-out-of-bounds Read in xlog_pack_data' [1]
has been fixed in master branch since v6.4-rc6-11-gf1e1765aad7d [2].
But, it still exist in LTS kernels: 5.4, 5.10, 5.15 [3], 6.1 [4]
Common c-reproducer code can be found here [5].

I've made backport f1e1765aad7d ("xfs: journal geometry is not properly bounds checked")
Patch for v5.15 & v6.1 is same with original upstream code.
Patches for v5.4 and v5.10 has some cosmetic variations:
`xfs_has_crc(mp)` call replaced by `xfs_sb_version_hascrc(&mp->m_sb)` at most.

I would be grateful for any assistance.

Regards,
AK

[1] https://syzkaller.appspot.com/bug?extid=b7854dc75e15ffc8c2ae
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=f1e1765aad7de7a8b8102044fc6a44684bc36180
[3] https://syzkaller.appspot.com/bug?extid=66f256de193ab682584f
[4] https://syzkaller.appspot.com/bug?extid=904ffc7f25c759741787
[5] https://syzkaller.appspot.com/text?tag=ReproC&x=152f7343280000

Reported-by: syzbot+66f256de193ab682584f@syzkaller.appspotmail.com
Reported-by: syzbot+904ffc7f25c759741787@syzkaller.appspotmail.com


