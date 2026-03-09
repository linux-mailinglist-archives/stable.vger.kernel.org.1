Return-Path: <stable+bounces-223471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BukgB3Ykrmnr/wEAu9opvQ
	(envelope-from <stable+bounces-223471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 02:37:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5814233109
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 02:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14BF7300FC57
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 01:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A51C860B;
	Mon,  9 Mar 2026 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RPjEpwzT"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E60199920
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773020274; cv=none; b=LDr4lYMh0c+BLpmfR9WdzQJ1U3Z21rN1RAgN+0Wtrrlciq2TeD0i7mTrZ+BFCjgABWBtYbQUMBtXJPaG+55TL8jHYuXtD9gjRh6zSS+dCnLHKQIS9hgPmWZ9XT0rdvmHpRn3NWhrbhCxLaCmsNTM7R+NUMc7R3ylpxBFwUuzhfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773020274; c=relaxed/simple;
	bh=2o1luC+jO2GgnVr33Qn49e/XkvNj+1bIkYoSPnu40rs=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=hrn/srZuY1ahnlldau6UNebALYrBWJiPFcq4BkE94nzj3sVxxIeRRoUoOZ2AVHKDWGcYD/MeQTaBmdIF7BTqzOleDyWZ28zm0/W3rXXRYl22/9zAXRxR2x7QUTYeSCezN3QR55sRt2Yk5Li/ViMbm2H4OZXaExIKbqqO3MHBEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RPjEpwzT; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2o1luC+jO2GgnVr33Qn49e/XkvNj+1bIkYoSPnu40rs=;
	b=RPjEpwzTAKH/rUyyFPaKxdt3Xa2Dn4uOlHXf9qzCpkHCAs+gwOPCUF4J3IVvuSZSO9zrwQbmh
	vRqs5BKCNHe2CcJh9Ew6OrNw0NEW6CiGvplUVYj2e9i+S5HVn88vPGyddFEzv3svu3LTzHk7sBW
	kF+W1+/l/hGS4iwYWyLSHLc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fTfd15bFsznTwN;
	Mon,  9 Mar 2026 09:32:05 +0800 (CST)
Received: from kwepemk100018.china.huawei.com (unknown [7.202.194.66])
	by mail.maildlp.com (Postfix) with ESMTPS id CB53F402AB;
	Mon,  9 Mar 2026 09:37:42 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by kwepemk100018.china.huawei.com
 (7.202.194.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 9 Mar
 2026 09:37:42 +0800
Message-ID: <e80b5e71-ad6b-4fbd-83a5-d6bbe4774f6b@huawei.com>
Date: Mon, 9 Mar 2026 09:37:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>
CC: <stable@vger.kernel.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
From: GONG Ruiqi <gongruiqi1@huawei.com>
Subject: Inquiry for linux-rolling-stable: move to 6.19.y?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100018.china.huawei.com (7.202.194.66)
X-Rspamd-Queue-Id: C5814233109
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223471-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongruiqi1@huawei.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Action: no action

Hi Greg, hi Sasha,

I notice that linux-rolling-stable is still on branch linux-6.18.y,
which has been assigned as longterm. Shall we switch the tag to
linux-6.19.y, the current stable?

BR,
Ruiqi

