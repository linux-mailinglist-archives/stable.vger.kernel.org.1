Return-Path: <stable+bounces-268780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bNyBAms/PmpXCAkAu9opvQ
	(envelope-from <stable+bounces-268780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:59:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87286CB86D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:59:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=S1ZFr7O0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268780-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268780-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7B1F3018597
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00003E716F;
	Fri, 26 Jun 2026 08:59:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1033E3DB3;
	Fri, 26 Jun 2026 08:59:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464349; cv=none; b=T16E5vihFLfcuwH8vB/Yh+EdFJBmbr1Q1a2X3FPTMaIMJBBwo9vSVDxdCzQzqnF3l3tr4AfSY3IfaVemZKHYv8tcwNKiRXt4elBwkld1CPMrG0AkIOgMso+NreGYeo/x5EuUc7M5AaXNLzjLyfrDiBeIQFZnBYAXF10//4PxSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464349; c=relaxed/simple;
	bh=1UF0WDNGhDqYTjziiC+O+RdTBtqnG+eCF4aTFyvq1dA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/d6u4/c3Wt6ezZOIxjreWK/zQBtJj7UQip5Ew+SWnmGClDHx8Tc3J2G+Q4BNW+ukqi9tWk5T9qwQf8r+rsS2CTfM2yS6+F+p69qEptpReauEDlmbVGajanWWEdXQn1NwZICOR7FrwWYry+fawMA9NnVzyNfvXngLG2yx2sQa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S1ZFr7O0; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=g6
	D9+ohCvg3vZ+/EOx6cBBl2sEkP0E6MD+F/xOBlluc=; b=S1ZFr7O0jqjDdPbXqW
	2/tuGvwWkvu1gAamVjK+MxN+mTq8PkTcLomqgPuXLoFo+FUv1zePBbMDLTN7T6aX
	/qhPA6K3eLesy0KyP7ITnGk9J8/oLmEC5EihynB/h/Kp5cqc8oUCVjyZxrdjBQdf
	Zx0gQfg1Z1pScDnhKmNGcxLb0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAX4WdMPz5qXqbaFg--.37560S2;
	Fri, 26 Jun 2026 16:58:53 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: vulab@iscas.ac.cn
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: Re: [PATCH] block: Fix dio->ref leak on integrity error in __blkdev_direct_IO()
Date: Fri, 26 Jun 2026 16:58:45 +0800
Message-Id: <20260626085845.3461889-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625092106.47695-1-vulab@iscas.ac.cn>
References: <20260625092106.47695-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX4WdMPz5qXqbaFg--.37560S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUenmRDUUUU
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwg0NnWo+P02AAwAA36
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:yangxiuwei@kylinos.cn,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yangxiuwei@kylinos.cn,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268780-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D87286CB86D

---

Hi Wentao,

On Thu, Jun 25, 2026 at 05:21:06PM +0800, Wentao Liang wrote:
> Fix by matching the existing error handling pattern used for
> blkdev_iov_iter_get_pages() failure: end the current bio with an error
> status and break out of the submission loop.

Looks good to me.

> +			if (unlikely(ret)) {
> +				bio->bi_status = errno_to_blk_status(ret);
> +				bio_endio(bio);
> +				break;
> +			}

Small nit: consider bio_endio_status(bio, errno_to_blk_status(ret))
instead, now that the helper exists.

Reviewed-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

Thanks,
Yang Xiuwei


