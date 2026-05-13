Return-Path: <stable+bounces-246872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ObZMeeHBGoJLQIAu9opvQ
	(envelope-from <stable+bounces-246872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:17:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F99534D8F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECCF7301B06F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0E2E11A6;
	Wed, 13 May 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JWcMztLE"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7612D3725;
	Wed, 13 May 2026 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681028; cv=none; b=ZjMhHEFnfs2C2p4Wu2eo+rJyoRdfz3681e/AKtIl2s4gJfhvJS+8x2uy4FlWCmq6beH8vOleHKufAySkjekBBdtRsf/FlmftjnbC1f2blJ9IZ++57YHMGp2z0Y/I2DzYp9On6RsyffWQl3lpQmvt+6sOwVUk+ynmjxTxiRrWOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681028; c=relaxed/simple;
	bh=+DlhqxbsUxs8TSFy328TyjZOji9gRCtPaLK2MQ9YrE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTaPN23S40goZkUr3BwP0onqQRqGwuevUe3KQXzaob+Z6fxt1B5PGiR7zFzlT2XDIMTO4HJO3mgbjPC5qYYHNj6mPMnvQn9kd/V1Ro5/ChGrWFFGv32PV69elWvyeA5UNFi4PVebkHVBQIKvC3xnGNDt3OKrNw26WN264deq96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JWcMztLE; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/l
	wiOPTnvlBpog3cv49D12gfGRsm5qJ0BLZQamnSSg0=; b=JWcMztLEhA7kS0JHqg
	EmpAqZK9WQoqCxXZzTk5weZVCoW5P+6gMt9FWbXLePTUj99/RmkKih2od4xB9KkN
	mMIcTzWJKPsUHJUCMa6ZdpHsRESXVyZfJOgRyWkT3SCfLP+WuD+23QBggiJUOYhm
	e1kSjxxpLh3U6zFEF4St6CCIc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXniBxhARqrEiHDg--.29S2;
	Wed, 13 May 2026 22:02:27 +0800 (CST)
From: wang wei <a929244872@163.com>
To: richardycc@google.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bgeffon@google.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liumartin@google.com,
	minchan@kernel.org,
	senozhatsky@chromium.org,
	stable@vger.kernel.org,
	wang wei <a929244872@163.com>
Subject: [PATCH] Re:[PATCH v3] zram: fix use-after-free in zram_writeback_endio
Date: Wed, 13 May 2026 22:02:18 +0800
Message-Id: <20260513140218.7425-1-a929244872@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260512074918.2606208-1-richardycc@google.com>
References: <20260512074918.2606208-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXniBxhARqrEiHDg--.29S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRPrcfUUUUU
X-CM-SenderInfo: jdzsmjiuuylji6rwjhhfrp/xtbC6hTZgGoEhHRf4wAA3F
X-Rspamd-Queue-Id: C7F99534D8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246872-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,google.com,vger.kernel.org,kvack.org,kernel.org,chromium.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a929244872@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

>@@ -847,7 +849,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
> 		release_wb_req(req);
> 	}
>
>-	kfree(wb_ctl);
>+	kfree_rcu(wb_ctl, rcu);
> }

Do we need to add a 'rcu_assign_pointer(wb_ctl, NULL);' before 'kfree_rcu(wb_ctl, rcu)'?

Signed-off-by: wang wei <a929244872@163.com>

-- 
2.25.1


