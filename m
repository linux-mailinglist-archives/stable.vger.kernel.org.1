Return-Path: <stable+bounces-115017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 991DCA320F2
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0CC17A23F1
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E92054E0;
	Wed, 12 Feb 2025 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NnTp4/IK"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904CC13C9B3;
	Wed, 12 Feb 2025 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348641; cv=none; b=eRoQy/bpSd3u0TZliz1bNhE+lp1YcCspxHFZFZi/3oiWGOXHmgxZQyEx6hJR7I2PIjPwmNHIDjDMDFQtQy1MdBq8qMtB/iEPxEhL5szoXVlYde9j5rmY3DH63xJyXQo0Q6AfzrlX68QCTFLDSlXta5fzNWxEyp/A3CbrhV/MQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348641; c=relaxed/simple;
	bh=41oRUPaUFlJuFpT0qxGUd6zD6GuKe3mpoJ1IuxQKq9k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TpYL/fNOc3QQEqQJgsh2ULCDLodWQdQFf0p1SmYOXuYwyb3RFaZdoFbCQvFiy01icqfopOSSannmK8WK+ChZaEIh8YSH0BEjUOU8sG9dhqC1Q0Twr3yFfbpqztHQtkLap3b+g53TBHwRaqE4APSUB0WnVFAHg3IcVd8UmbqN38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NnTp4/IK; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4BF743284;
	Wed, 12 Feb 2025 08:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739348630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8xCSKqhDUpuPkZmj4vQowe/WposBKGNhZ/XQWdD8D3E=;
	b=NnTp4/IKL3UDJsvhrS+lP+3DUVPgf3VXZ21HhS218PY08yS5300z1UOHFzgdStoy3BDJBJ
	6/w4VAk/sy7B1yJCnHTTFtQ5CDsSshMBwDi0NOOumwGPjA8RBFcG1+7i2fG+gLAgSP9VC1
	KR0whZBWA5Nv6rxdpauYMi1xUFLQg5p+OXOON73W/yU4SXr9xb/eDKknf3gQdPWHLHPOlz
	FdxkHRWWc8fQ1FpKm1eW6QpnHI0Np9B73gjfl6Xrkx2wIJymjODsgG6SgTOIBvBnuNgp5E
	bz8keJ87Y52RYmpZ40hzlzScggx+vppVBEc5BcYlQtcpb7F5at2YLnbpZDMZYg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net 0/2] rtnetlink: Fix small memory leaks
Date: Wed, 12 Feb 2025 09:23:46 +0100
Message-Id: <20250212-rtnetlink_leak-v1-0-27bce9a3ac9a@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJJarGcC/x2MQQqAIBAAvyJ7TmiNQPpKRJittSQWGhFEf2/pO
 DAzDxTKTAU69UCmiwvvSQArBX51aSHNszCY2rS1QdT5THRGTtsYyW3aTmi8a71tQgMSHZkC3/+
 wBzFheN8PxXHFX2UAAAA=
X-Change-ID: 20250211-rtnetlink_leak-8b12ca5c83f3
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffdvfedvtedvkeduudffueeifedujedvveekfedvteeguddugfeklefhhefhudeunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrheegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihihuhesrghmrgiiohhnrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrghsthhivghnr
 dgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

I ran into a small memory leak while working on the BPF selftests suite
on the bpf-next tree. It leads to an oom-kill after thousands of iterations
in the qemu environment provided by tools/testing/selftests/bpf/vmtest.sh.

To reproduce the issue from the net-next tree:
$ git remote add bpf-next https://github.com/kernel-patches/bpf
$ git fetch bpf-next
$ git cherry-pick 723f1b9ce332^..edb996fae276
$ tools/testing/selftests/bpf/vmtest.sh -i -s "bash -c 'for i in {1..8192}; do ./test_progs -t xdp_veth_redirect; done'"
[... coffee break ...]
[ XXXX.YYYYYY] sh invoked oom-killer: gfp_mask=0x440dc0(GFP_KERNEL_ACCOUNT|__GFP_COMP|__GFP_ZERO), order=0, oom_score_adj=0
[...]
[ XXXX.YYYYYY] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/,task=bash,pid=116,uid=0
[ XXXX.YYYYYY] Out of memory: Killed process 116 (bash) total-vm:6816kB, anon-rss:2816kB, file-rss:240kB, shmem-rss:0kB, UID:0 pgtables:48kB oom_score_adj:0

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (eBPF Foundation) (2):
      rtnetlink: Fix rtnl_net_cmp_locks() when DEBUG is off
      rtnetlink: Release nets when leaving rtnl_setlink()

 net/core/rtnetlink.c | 4 ++++
 1 file changed, 4 insertions(+)
---
base-commit: 5d332c1ad3226c0a31653dbf2391bd332e157625
change-id: 20250211-rtnetlink_leak-8b12ca5c83f3

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


