Return-Path: <stable+bounces-254438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKHRCBP1FWqzfwcAu9opvQ
	(envelope-from <stable+bounces-254438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:31:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF55DC02C
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 630CA301A1C6
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDAF377009;
	Tue, 26 May 2026 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="IovMVJvl"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490950276
	for <stable@vger.kernel.org>; Tue, 26 May 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823610; cv=none; b=CJ+9tQ/n8Q+hFn8FZ4ixuCioKdBZ7IVKPwwDSA0x/u2jrAtzMfS8iOB6ARdLFeGYvSoBMzew4SRjkq0LFnVWZL8PxsYUOYXTaWhOylowsURzsxAitbl9BndyR0ES0tjCkv/JzpXulWaZlX4bi9BfpLamqmTHTFQOHEYgyz8WmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823610; c=relaxed/simple;
	bh=aaLEXkMrgcqFKZQO/F24LufxbjfS0rWy8m2vfX1bBRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0sx2NkjTD4AnmsHjTOUojcF5fhM8+8BMEE9vKNYXMJMKMGUHszhLs5Gcz4GpifwFWDHgvfxJAmT5xg++fehOA/SXxzYEz/OqOC1mfU2rg0zDkOXYyNNdt+zHlBRwI5xTGqoxlpAxcIGD2uJaOOzrzuenQe1ynzrWNyLg7XmgVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=IovMVJvl; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779823609; x=1811359609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aaLEXkMrgcqFKZQO/F24LufxbjfS0rWy8m2vfX1bBRc=;
  b=IovMVJvltxWNYT0c+zWob2Xd6vnpCbFsntwIcXaihrW1D5EFWtrKBMrS
   hiOKZ9nGkokD212fUpzOq3HXhSn2Ua7qisZTk21Mq1WyIkkvJfwhM3EoZ
   WhLLnaCOGkVwRLlFTW22usR3Ua/Fa4xPZO4q6xvnrB+f0QqMTLhbUlGNF
   RIBAxAGoKIZfsBRDsEDZF/qNnzT+MAvaeO+8b0p6QQOqUyo3nkr6mRgq3
   aaC/VPsIvakWjpsthZ0EzHgA89yLvp+impl9f7RvpoTbMuTBjxU9vHyzg
   IP86QJ6UnUw/+lnSzoiB3C7LvkQZO2ogF+ZvhG6SNY+gF0w2eWVB4wZKc
   Q==;
X-CSE-ConnectionGUID: I5jAkgQHTROWJW0T355jWA==
X-CSE-MsgGUID: lXatkgkmQluhUB0YJj3j6Q==
X-IronPort-AV: E=Sophos;i="6.24,170,1774310400"; 
   d="scan'208";a="20011972"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 19:26:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:27631]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.115:2525] with esmtp (Farcaster)
 id 890ef666-4454-4689-899c-6e5a77486ddb; Tue, 26 May 2026 19:26:46 +0000 (UTC)
X-Farcaster-Flow-ID: 890ef666-4454-4689-899c-6e5a77486ddb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:26:46 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:26:44 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <pulehui@huawei.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alexghiti@rivosinc.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <bjorn@rivosinc.com>,
	<linux-riscv@lists.infradead.org>, kernel test robot <lkp@intel.com>,
	"Gyokhan Kochmarla" <gyokhan@amazon.de>
Subject: [PATCH 6.12] riscv: fgraph: Select HAVE_FUNCTION_GRAPH_TRACER depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
Date: Tue, 26 May 2026 19:26:35 +0000
Message-ID: <20260526192636.83171-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254438-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:email,amazon.de:mid,amazon.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gyokhan@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 69BF55DC02C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogUHUgTGVodWkgPHB1bGVodWlAaHVhd2VpLmNvbT4KCmNvbW1pdCBlOGViOGUxYmRhZTk0
YjllMDAzZjU5MDk1MTlmZDMxMWQwOTM2ODkwIHVwc3RyZWFtLgoKQ3VycmVudGx5LCBmZ3JhcGgg
b24gcmlzY3YgcmVsaWVzIG9uIHRoZSBpbmZyYXN0cnVjdHVyZSBvZgpEWU5BTUlDX0ZUUkFDRV9X
SVRIX0FSR1MuIEhvd2V2ZXIsIERZTkFNSUNfRlRSQUNFX1dJVEhfQVJHUyBtYXkgYmUKdHVybmVk
IG9mZiBvbiByaXNjdiwgd2hpY2ggd2lsbCBjYXVzZSB0aGUgZW5hYmxlZCBmZ3JhcGggdG8gYmUg
YWJub3JtYWwuClRoZXJlZm9yZSwgbGV0J3Mgc2VsZWN0IEhBVkVfRlVOQ1RJT05fR1JBUEhfVFJB
Q0VSIGRlcGVuZHMgb24KSEFWRV9EWU5BTUlDX0ZUUkFDRV9XSVRIX0FSR1MuCgpGaXhlczogYTNl
ZDQxNTdiN2Q4ICgiZmdyYXBoOiBSZXBsYWNlIGZncmFwaF9yZXRfcmVncyB3aXRoIGZ0cmFjZV9y
ZWdzIikKUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgpDbG9z
ZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyNTAzMTYwODIwLmR2
cU1wSDBnLWxrcEBpbnRlbC5jb20vClNpZ25lZC1vZmYtYnk6IFB1IExlaHVpIDxwdWxlaHVpQGh1
YXdlaS5jb20+ClJldmlld2VkLWJ5OiBCasO2cm4gVMO2cGVsIDxiam9ybkByaXZvc2luYy5jb20+
Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMTcwMzEyMTQuNDEzODQzNi0x
LXB1bGVodWlAaHVhd2VpY2xvdWQuY29tClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRyZSBHaGl0aSA8
YWxleGdoaXRpQHJpdm9zaW5jLmNvbT4KU2lnbmVkLW9mZi1ieTogR3lva2hhbiBLb2NobWFybGEg
PGd5b2toYW5AYW1hem9uLmRlPgotLS0KIGFyY2gvcmlzY3YvS2NvbmZpZyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Fy
Y2gvcmlzY3YvS2NvbmZpZyBiL2FyY2gvcmlzY3YvS2NvbmZpZwppbmRleCA5ZTg2NjdhNTIzZDUu
LjFjNzU3NTgxNjc5NSAxMDA2NDQKLS0tIGEvYXJjaC9yaXNjdi9LY29uZmlnCisrKyBiL2FyY2gv
cmlzY3YvS2NvbmZpZwpAQCAtMTQzLDcgKzE0Myw3IEBAIGNvbmZpZyBSSVNDVgogCXNlbGVjdCBI
QVZFX0RZTkFNSUNfRlRSQUNFX1dJVEhfRElSRUNUX0NBTExTCiAJc2VsZWN0IEhBVkVfRFlOQU1J
Q19GVFJBQ0VfV0lUSF9BUkdTIGlmIEhBVkVfRFlOQU1JQ19GVFJBQ0UKIAlzZWxlY3QgSEFWRV9G
VFJBQ0VfTUNPVU5UX1JFQ09SRCBpZiAhWElQX0tFUk5FTAotCXNlbGVjdCBIQVZFX0ZVTkNUSU9O
X0dSQVBIX1RSQUNFUgorCXNlbGVjdCBIQVZFX0ZVTkNUSU9OX0dSQVBIX1RSQUNFUiBpZiBIQVZF
X0RZTkFNSUNfRlRSQUNFX1dJVEhfQVJHUwogCXNlbGVjdCBIQVZFX0ZVTkNUSU9OX0dSQVBIX0ZS
RUdTCiAJc2VsZWN0IEhBVkVfRlVOQ1RJT05fVFJBQ0VSIGlmICFYSVBfS0VSTkVMICYmICFQUkVF
TVBUSU9OCiAJc2VsZWN0IEhBVkVfRUJQRl9KSVQgaWYgTU1VCi0tIAoyLjQ3LjMKCgoKCkFtYXpv
biBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFu
ei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdG9mIEhlbGxt
aXMsIEFuZHJlYXMgU3RpZWdlcgpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVu
YnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1
OTcK


