Return-Path: <stable+bounces-226994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOaTNDdeumkoVgIAu9opvQ
	(envelope-from <stable+bounces-226994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:11:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D34D2B7965
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE9C1305DB94
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46EB3793AD;
	Wed, 18 Mar 2026 08:03:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.189.cn (189sx01-ptr.21cn.com [125.88.204.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC073783CB
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.88.204.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820991; cv=none; b=jWn+o82HYCPHPwt3uBoDihFOoEtAgQn2EoPCX/zop8HvZFuoIE87gQuFVa6QXhM95L3GCHe4mV8XMFm/xW46yT8vOFjg5b74EQndiARXynMVeg/r+4GfqOfn/dkpld9rBtiYYxSDKELLxsfIPO8sY5gHdtFb2QDwnFxhkbS8BGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820991; c=relaxed/simple;
	bh=2saFksvTnkZn8vEItQm3ySP/bZMl1VdZEGYa10cwlc0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=idGb54dpzJ94fyZQB6wJjjsR06dYYXKxL7+gHRxnmxJe7eR2NJK6ge0laKaMmNd6ef9t6oMNOHByOAf3Wun1ZwQTC+mvdGQKwTRZB+T98CIQ2jOxXacyIlRkvbUjy6/cOZRGoWHjKp+YYz9DDjGOSvZYVFd/aSDcKX73AtcW7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=125.88.204.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.1302372711
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-106.121.140.245 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id E9A164002FF;
	Wed, 18 Mar 2026 16:03:03 +0800 (CST)
Received: from  ([106.121.140.245])
	by gateway-153622-dep-76cc7bc9cd-r45x9 with ESMTP id 73a26034910647118feeb223a53192b5 for nuno.sa@analog.com;
	Wed, 18 Mar 2026 16:03:03 CST
X-Transaction-ID: 73a26034910647118feeb223a53192b5
X-Real-From: charles_xu@189.cn
X-Receive-IP: 106.121.140.245
X-MEDUSA-Status: 0
Sender: charles_xu@189.cn
From: Charles Xu <charles_xu@189.cn>
To: nuno.sa@analog.com,
	jstephan@baylibre.com,
	Jonathan.Cameron@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] driver: iio: add missing checks on iio_info's callback access
Date: Wed, 18 Mar 2026 16:03:02 +0800
Message-Id: <20260318080302.8953-1-charles_xu@189.cn>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226994-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[189.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[charles_xu@189.cn,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.869];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	FREEMAIL_FROM(0.00)[189.cn];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,baylibre.com:email,189.cn:email,189.cn:mid]
X-Rspamd-Queue-Id: 3D34D2B7965
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Julien Stephan <jstephan@baylibre.com>

[ Upstream commit c4ec8dedca961db056ec85cb7ca8c9f7e2e92252 ]

Some callbacks from iio_info structure are accessed without any check, so
if a driver doesn't implement them trying to access the corresponding
sysfs entries produce a kernel oops such as:

[ 2203.527791] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when execute
[...]
[ 2203.783416] Call trace:
[ 2203.783429]  iio_read_channel_info_avail from dev_attr_show+0x18/0x48
[ 2203.789807]  dev_attr_show from sysfs_kf_seq_show+0x90/0x120
[ 2203.794181]  sysfs_kf_seq_show from seq_read_iter+0xd0/0x4e4
[ 2203.798555]  seq_read_iter from vfs_read+0x238/0x2a0
[ 2203.802236]  vfs_read from ksys_read+0xa4/0xd4
[ 2203.805385]  ksys_read from ret_fast_syscall+0x0/0x54
[ 2203.809135] Exception stack(0xe0badfa8 to 0xe0badff0)
[ 2203.812880] dfa0:                   00000003 b6f10f80 00000003 b6eab000 00020000 00000000
[ 2203.819746] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 00000000 00020000 00000000
[ 2203.826619] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0
[ 2203.830363] Code: bad PC value
[ 2203.832695] ---[ end trace 0000000000000000 ]---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Link: https://lore.kernel.org/r/20240530-iio-core-fix-segfault-v3-1-8b7cd2a03773@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Charles Xu <charles_xu@189.cn>
---
 drivers/iio/industrialio-core.c  |  7 ++++++-
 drivers/iio/industrialio-event.c |  9 ++++++++
 drivers/iio/inkern.c             | 35 ++++++++++++++++++++++----------
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d21df1d300d2..c52b79a86ab4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -776,9 +776,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
 							INDIO_MAX_RAW_ELEMENTS,
 							vals, &val_len,
 							this_attr->address);
-	else
+	else if (indio_dev->info->read_raw)
 		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
 				    &vals[0], &vals[1], this_attr->address);
+	else
+		return -EINVAL;
 
 	if (ret < 0)
 		return ret;
@@ -860,6 +862,9 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 	int length;
 	int type;
 
+	if (!indio_dev->info->read_avail)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_avail(indio_dev, this_attr->c,
 					  &vals, &type, &length,
 					  this_attr->address);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 07bf47a1a356..8f28f27e9424 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -277,6 +277,9 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (!indio_dev->info->write_event_config)
+		return -EINVAL;
+
 	ret = indio_dev->info->write_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), val);
@@ -292,6 +295,9 @@ static ssize_t iio_ev_state_show(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val;
 
+	if (!indio_dev->info->read_event_config)
+		return -EINVAL;
+
 	val = indio_dev->info->read_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr));
@@ -310,6 +316,9 @@ static ssize_t iio_ev_value_show(struct device *dev,
 	int val, val2, val_arr[2];
 	int ret;
 
+	if (!indio_dev->info->read_event_value)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_event_value(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 8815747e67be..4ab3a621399b 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -517,6 +517,7 @@ EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
 static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 	enum iio_chan_info_enum info)
 {
+	const struct iio_info *iio_info = chan->indio_dev->info;
 	int unused;
 	int vals[INDIO_MAX_RAW_ELEMENTS];
 	int ret;
@@ -528,15 +529,19 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 	if (!iio_channel_has_info(chan->channel, info))
 		return -EINVAL;
 
-	if (chan->indio_dev->info->read_raw_multi) {
-		ret = chan->indio_dev->info->read_raw_multi(chan->indio_dev,
-					chan->channel, INDIO_MAX_RAW_ELEMENTS,
-					vals, &val_len, info);
+	if (iio_info->read_raw_multi) {
+		ret = iio_info->read_raw_multi(chan->indio_dev,
+					       chan->channel,
+					       INDIO_MAX_RAW_ELEMENTS,
+					       vals, &val_len, info);
 		*val = vals[0];
 		*val2 = vals[1];
-	} else
-		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
-					chan->channel, val, val2, info);
+	} else if (iio_info->read_raw) {
+		ret = iio_info->read_raw(chan->indio_dev,
+					 chan->channel, val, val2, info);
+	} else {
+		return -EINVAL;
+	}
 
 	return ret;
 }
@@ -754,11 +759,15 @@ static int iio_channel_read_avail(struct iio_channel *chan,
 				  const int **vals, int *type, int *length,
 				  enum iio_chan_info_enum info)
 {
+	const struct iio_info *iio_info = chan->indio_dev->info;
+
 	if (!iio_channel_has_available(chan->channel, info))
 		return -EINVAL;
 
-	return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
-						 vals, type, length, info);
+	if (iio_info->read_avail)
+		return iio_info->read_avail(chan->indio_dev, chan->channel,
+					    vals, type, length, info);
+	return -EINVAL;
 }
 
 int iio_read_avail_channel_attribute(struct iio_channel *chan,
@@ -889,8 +898,12 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
 static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 			     enum iio_chan_info_enum info)
 {
-	return chan->indio_dev->info->write_raw(chan->indio_dev,
-						chan->channel, val, val2, info);
+	const struct iio_info *iio_info = chan->indio_dev->info;
+
+	if (iio_info->write_raw)
+		return iio_info->write_raw(chan->indio_dev,
+					   chan->channel, val, val2, info);
+	return -EINVAL;
 }
 
 int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
-- 
2.35.3


