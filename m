Return-Path: <stable+bounces-262169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iresLMKEJ2rqyQIAu9opvQ
	(envelope-from <stable+bounces-262169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 05:13:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5665BFF1
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 05:13:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=Upsn0Izl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262169-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262169-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E244F3021588
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 03:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639B363C5A;
	Tue,  9 Jun 2026 03:13:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC935E1D9;
	Tue,  9 Jun 2026 03:12:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974783; cv=none; b=E78im8WpjgeaEyc5I/k8bvXQ+0Vn6sUfwIouzvOHrQ3yRWi3Qj0aD6y68qiAI37wYeOzW+WImO03yH23jzgwzlg13zEmrwj+I4an4KM6KBWPbVw+iHnl95SFGHasFf3DAj8NNBLCEuKJkjl94QgMBYe1MybKX5JIYXIfDBXLwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974783; c=relaxed/simple;
	bh=xMgcYcolNdpZFjTTRkA44kIuPU/eKVBzDgStF/3Ch4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJfwjiZj+6J+hJTiQzQbyp48h4WRV6hxqx1uLdwK0h+YGKe+dkgfqf0x7fc3tqQokkvOrnA2OjbeO3WW6nPF40H2e4WxSzQQ4OrsNsMQ5QVFPuYUH5tjrappAq/HGt4dLtuUogVk2YH/Eak/dE4lAaVsmmxfPZQx8zPLD6TgLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Upsn0Izl; arc=none smtp.client-ip=117.135.210.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=44
	1oI75A3DiUMyUNb96b+ndobyPHuqxaJuMlZ8Mxlsk=; b=Upsn0IzlUv5jmnULn7
	6oFFSjknORw15wB5PDSNScXkexPdpak1nn5arHRSct/enbUZ2kW7MpJOFbni9Eks
	1PGjPwrwY4HKROxB7a8ge1oUbdh4XlGlxF5MG18k6E+H9wndNWjsu7vbjvkH9eGV
	v3YWgbHjztKfhEJTGqck8eyTI=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wC3tOqdhCdqU+8qCQ--.4915S2;
	Tue, 09 Jun 2026 11:12:33 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	linux-i2c@vger.kernel.org,
	wsa+renesas@sang-engineering.com
Subject: Please cherry-pick commit 617eb7c0961a
Date: Tue,  9 Jun 2026 11:12:27 +0800
Message-Id: <20260609031227.21001-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3tOqdhCdqU+8qCQ--.4915S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU24lkDUUUU
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAAGtkWonhKHMqgAA3z
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:linux-i2c@vger.kernel.org,m:wsa+renesas@sang-engineering.com,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262169-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50C5665BFF1

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Hi,

Please cherry-pick the following upstream commit into stable trees 
from 5.10 up to 7.0:

617eb7c0961a8dfcfc811844a6396e406b2923ea

It fixes a local DoS via userspace-controlled integer overflow 
in the I2C_TIMEOUT ioctl.

The patch applies cleanly to all active LTS branches.

Thanks,
Mingyu Wang


