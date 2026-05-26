Return-Path: <stable+bounces-254437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFuGKd7zFWqzfwcAu9opvQ
	(envelope-from <stable+bounces-254437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:26:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABE95DBF72
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 624C73012334
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF35E377009;
	Tue, 26 May 2026 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Yu5SyY7G"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE935B653
	for <stable@vger.kernel.org>; Tue, 26 May 2026 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823577; cv=none; b=KUY5DO8JNKkYuLZ1/stEMGFooENU15UugkQEcbH9MXMHEe81VklSPt0eCXo6xREQNGAxtb8K5bL7z21kD6xKSJzuc7F3FjX3Q5SLkOSQVl7OlvEieZC9FICROakHcCOIdKVm88k8alveML+AaJue99DPwQgR2N5xlY4e3h+HSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823577; c=relaxed/simple;
	bh=jHWNVd6DNeRGjD4EJJtXndLBQ5dBxvwGdHjBsWiSKqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BvUUMfc9pHviuhoiuHgDoKm+6VMhEqLPIW0BE0FEtxrRbkrLBl0thldUle88C3GeFkkHkkmrnofmkpqYtQXohm7Df9/hoBVA/MmQO1p+4EExqMnvnZvmTJJvfZbiSZObVqdMkQ53Vsec0Q4PjFieboO+ZYseTgfRRRZBn9gS+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Yu5SyY7G; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779823575; x=1811359575;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jHWNVd6DNeRGjD4EJJtXndLBQ5dBxvwGdHjBsWiSKqU=;
  b=Yu5SyY7GaMe/7fwFvpWnVY6jMa+kBvC6D0H/wvFxVw2L8KsYeAc+W4qX
   F3YjfHc27CKHBFWY4VSlsegHh7ZQZ4hMSJebajTEVUqhe9XzfwMInAlcF
   XS3qKICqxsmWtT2asLZDzz8UXs51z1XwdLuD89/YGsNBhlvFXCCAdNpsh
   +TsmyGed3pT2IYuSquAtCmge37kTTm2kAd7Wc+s4IQTNcctUB6PYPwu9I
   ol4hNAGUjEMtgwWCgJqradEgwiFFQqijdkCFAiiu2hzI/wAr8KB1o3gQq
   2K+vo3OiE7HN4MFtmUUlMZ2ZsJp848E8XG3RxOnG6aPpFkNC8gFyouQDg
   Q==;
X-CSE-ConnectionGUID: yfAvRuyqQZChc3WOwEtUdQ==
X-CSE-MsgGUID: YkBSmXRJR0eVYFkDgUOZSg==
X-IronPort-AV: E=Sophos;i="6.24,170,1774310400"; 
   d="scan'208";a="20301471"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 19:26:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:28735]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.30:2525] with esmtp (Farcaster)
 id c6b854cc-f218-4dad-b1c8-c48161f06ecf; Tue, 26 May 2026 19:26:12 +0000 (UTC)
X-Farcaster-Flow-ID: c6b854cc-f218-4dad-b1c8-c48161f06ecf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:26:11 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:26:09 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <pulehui@huawei.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alexghiti@rivosinc.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <bjorn@rivosinc.com>,
	<linux-riscv@lists.infradead.org>, Linux Kernel Functional Testing
	<lkft@linaro.org>, Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: [PATCH 6.12] riscv: fgraph: Fix stack layout to match __arch_ftrace_regs argument of ftrace_return_to_handler
Date: Tue, 26 May 2026 19:25:17 +0000
Message-ID: <20260526192517.82022-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254437-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,amazon.de:email,amazon.de:mid,amazon.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gyokhan@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1ABE95DBF72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogUHUgTGVodWkgPHB1bGVodWlAaHVhd2VpLmNvbT4KCmNvbW1pdCA2N2E1YmE4Zjc0MmYy
NDdiYzgzZTQ2ZGQyMzEzYzE0MmIxMzgzMjc2IHVwc3RyZWFtLgoKTmFyZXNoIEthbWJvanUgcmVw
b3J0ZWQgYSAiQmFkIGZyYW1lIHBvaW50ZXIiIGtlcm5lbCB3YXJuaW5nIHdoaWxlCnJ1bm5pbmcg
TFRQIHRyYWNlIGZ0cmFjZV9zdHJlc3NfdGVzdC5zaCBpbiByaXNjdi4gV2UgY2FuIHJlcHJvZHVj
ZSB0aGUKc2FtZSBpc3N1ZSB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoKCmBgYAokIGNkIC9z
eXMva2VybmVsL2RlYnVnL3RyYWNpbmcKJCBlY2hvICdmOm15cHJvYmUgZG9fbmFub3NsZWVwJXJl
dHVybiBhcmdzMT0kcmV0dmFsJyA+IGR5bmFtaWNfZXZlbnRzCiQgZWNobyAxID4gZXZlbnRzL2Zw
cm9iZXMvZW5hYmxlCiQgZWNobyAxID4gdHJhY2luZ19vbgokIHNsZWVwIDEKYGBgCgpBbmQgd2Ug
Y2FuIGdldCB0aGUgZm9sbG93aW5nIGtlcm5lbCB3YXJuaW5nOgoKWyAgMTI3LjY5Mjg4OF0gLS0t
LS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tClsgIDEyNy42OTM3NTVdIEJhZCBmcmFt
ZSBwb2ludGVyOiBleHBlY3RlZCBmZjIwMDAwMDAwNjViZTUwLCByZWNlaXZlZCBiYTM0YzE0MWU5
NTk0MDAwClsgIDEyNy42OTM3NTVdICAgZnJvbSBmdW5jIGRvX25hbm9zbGVlcCByZXR1cm4gdG8g
ZmZmZmZmZmY4MDBjY2IxNgpbICAxMjcuNjk4Njk5XSBXQVJOSU5HOiBDUFU6IDEgUElEOiAxMjkg
YXQga2VybmVsL3RyYWNlL2ZncmFwaC5jOjc1NSBmdHJhY2VfcmV0dXJuX3RvX2hhbmRsZXIrMHgx
YjIvMHgxYmUKWyAgMTI3LjY5OTg5NF0gTW9kdWxlcyBsaW5rZWQgaW46ClsgIDEyNy43MDA5MDhd
IENQVTogMSBVSUQ6IDAgUElEOiAxMjkgQ29tbTogc2xlZXAgTm90IHRhaW50ZWQgNi4xNC4wLXJj
My1nMGFiMTkxYzc0NjQyICMzMgpbICAxMjcuNzAxNDUzXSBIYXJkd2FyZSBuYW1lOiByaXNjdi12
aXJ0aW8scWVtdSAoRFQpClsgIDEyNy43MDE4NTldIGVwYyA6IGZ0cmFjZV9yZXR1cm5fdG9faGFu
ZGxlcisweDFiMi8weDFiZQpbICAxMjcuNzAyMDMyXSAgcmEgOiBmdHJhY2VfcmV0dXJuX3RvX2hh
bmRsZXIrMHgxYjIvMHgxYmUKWyAgMTI3LjcwMjE1MV0gZXBjIDogZmZmZmZmZmY4MDEzYjVlMCBy
YSA6IGZmZmZmZmZmODAxM2I1ZTAgc3AgOiBmZjIwMDAwMDAwNjViZDEwClsgIDEyNy43MDIyMjFd
ICBncCA6IGZmZmZmZmZmODE5YzEyZjggdHAgOiBmZjYwMDAwMDgwODUzMTAwIHQwIDogNmUwMDAw
MDAwMDAwMDAwMApbICAxMjcuNzAyMjg0XSAgdDEgOiAwMDAwMDAwMDAwMDAwMDIwIHQyIDogNmU3
NTY2MjA2ZDZmNzI2NiBzMCA6IGZmMjAwMDAwMDA2NWJkODAKWyAgMTI3LjcwMjM0Nl0gIHMxIDog
ZmY2MDAwMDA4MTI2MjAwMCBhMCA6IDAwMDAwMDAwMDAwMDAwN2IgYTEgOiBmZmZmZmZmZjgxODk0
ZjIwClsgIDEyNy43MDI0MDhdICBhMiA6IDAwMDAwMDAwMDAwMDAwMTAgYTMgOiBmZmZmZmZmZmZm
ZmZmZmZlIGE0IDogMDAwMDAwMDAwMDAwMDAwMApbICAxMjcuNzAyNDcwXSAgYTUgOiAwMDAwMDAw
MDAwMDAwMDAwIGE2IDogMDAwMDAwMDAwMDAwMDAwOCBhNyA6IDAwMDAwMDAwMDAwMDAwMzgKWyAg
MTI3LjcwMjUzMF0gIHMyIDogYmEzNGMxNDFlOTU5NDAwMCBzMyA6IDAwMDAwMDAwMDAwMDAwMDAg
czQgOiBmZjIwMDAwMDAwNjViZGQwClsgIDEyNy43MDI1OTFdICBzNSA6IDAwMDA3ZmZmOGFkY2Y0
MDAgczYgOiAwMDAwNTU1NTZkYzFkOGMwIHM3IDogMDAwMDAwMDAwMDAwMDA2OApbICAxMjcuNzAy
NjUxXSAgczggOiAwMDAwN2ZmZjhhZGY1ZDEwIHM5IDogMDAwMDAwMDAwMDAwMDA2ZCBzMTA6IDAw
MDAwMDAwMDAwMDAwMDEKWyAgMTI3LjcwMjcxMF0gIHMxMTogMDAwMDU1NTU3MzczNzdjOCB0MyA6
IGZmZmZmZmZmODE5ZDg5OWUgdDQgOiBmZmZmZmZmZjgxOWQ4OTllClsgIDEyNy43MDI3NjldICB0
NSA6IGZmZmZmZmZmODE5ZDg5YTAgdDYgOiBmZjIwMDAwMDAwNjViYjE4ClsgIDEyNy43MDI4MjZd
IHN0YXR1czogMDAwMDAwMDIwMDAwMDEyMCBiYWRhZGRyOiAwMDAwMDAwMDAwMDAwMDAwIGNhdXNl
OiAwMDAwMDAwMDAwMDAwMDAzClsgIDEyNy43MDMyOTJdIFs8ZmZmZmZmZmY4MDEzYjVlMD5dIGZ0
cmFjZV9yZXR1cm5fdG9faGFuZGxlcisweDFiMi8weDFiZQpbICAxMjcuNzAzNzYwXSBbPGZmZmZm
ZmZmODAwMTdiY2U+XSByZXR1cm5fdG9faGFuZGxlcisweDE2LzB4MjYKWyAgMTI3LjcwNDAwOV0g
WzxmZmZmZmZmZjgwMDE3YmI4Pl0gcmV0dXJuX3RvX2hhbmRsZXIrMHgwLzB4MjYKWyAgMTI3Ljcw
NDA1N10gWzxmZmZmZmZmZjgwMGQzMzUyPl0gY29tbW9uX25zbGVlcCsweDQyLzB4NTQKWyAgMTI3
LjcwNDExN10gWzxmZmZmZmZmZjgwMGQ0NGEyPl0gX19yaXNjdl9zeXNfY2xvY2tfbmFub3NsZWVw
KzB4YmEvMHgxMGEKWyAgMTI3LjcwNDE3Nl0gWzxmZmZmZmZmZjgwOTAxYzU2Pl0gZG9fdHJhcF9l
Y2FsbF91KzB4MTg4LzB4MjE4ClsgIDEyNy43MDQyOTVdIFs8ZmZmZmZmZmY4MDkwY2MzZT5dIGhh
bmRsZV9leGNlcHRpb24rMHgxNGEvMHgxNTYKWyAgMTI3LjcwNTQzNl0gLS0tWyBlbmQgdHJhY2Ug
MDAwMDAwMDAwMDAwMDAwMCBdLS0tCgpUaGUgcmVhc29uIGlzIHRoYXQgdGhlIHN0YWNrIGxheW91
dCBmb3IgY29uc3RydWN0aW5nIGFyZ3VtZW50IGZvciB0aGUKZnRyYWNlX3JldHVybl90b19oYW5k
bGVyIGluIHRoZSByZXR1cm5fdG9faGFuZGxlciBkb2VzIG5vdCBtYXRjaCB0aGUKX19hcmNoX2Z0
cmFjZV9yZWdzIHN0cnVjdHVyZSBvZiByaXNjdiwgbGVhZGluZyB0byB1bmV4cGVjdGVkIHJlc3Vs
dHMuCgpGaXhlczogYTNlZDQxNTdiN2Q4ICgiZmdyYXBoOiBSZXBsYWNlIGZncmFwaF9yZXRfcmVn
cyB3aXRoIGZ0cmFjZV9yZWdzIikKUmVwb3J0ZWQtYnk6IExpbnV4IEtlcm5lbCBGdW5jdGlvbmFs
IFRlc3RpbmcgPGxrZnRAbGluYXJvLm9yZz4KQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvQ0ErRzlmWXZwX29BeGVERmo4OFRrMnJmRVo3anRZS0FLU3dmWVM2Nj01N0RiOVRCZHlB
QG1haWwuZ21haWwuY29tClNpZ25lZC1vZmYtYnk6IFB1IExlaHVpIDxwdWxlaHVpQGh1YXdlaS5j
b20+ClJldmlld2VkLWJ5OiBBbGV4YW5kcmUgR2hpdGkgPGFsZXhnaGl0aUByaXZvc2luYy5jb20+
ClRlc3RlZC1ieTogQmrDtnJuIFTDtnBlbCA8Ympvcm5Acml2b3NpbmMuY29tPgpSZXZpZXdlZC1i
eTogTWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKSA8bWhpcmFtYXRAa2VybmVsLm9yZz4KTGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDMxNzAzMTIxNC40MTM4NDM2LTItcHVsZWh1
aUBodWF3ZWljbG91ZC5jb20KU2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIEdoaXRpIDxhbGV4Z2hp
dGlAcml2b3NpbmMuY29tPgpTaWduZWQtb2ZmLWJ5OiBHeW9raGFuIEtvY2htYXJsYSA8Z3lva2hh
bkBhbWF6b24uZGU+Ci0tLQogYXJjaC9yaXNjdi9rZXJuZWwvbWNvdW50LlMgfCAyNCArKysrKysr
KysrKy0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9tY291bnQuUyBiL2Fy
Y2gvcmlzY3Yva2VybmVsL21jb3VudC5TCmluZGV4IDA2ODE2ODA0NmUwZS4uZGE0YTQwMDBlNTdl
IDEwMDY0NAotLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9tY291bnQuUworKysgYi9hcmNoL3Jpc2N2
L2tlcm5lbC9tY291bnQuUwpAQCAtMTIsOCArMTIsNiBAQAogI2luY2x1ZGUgPGFzbS9hc20tb2Zm
c2V0cy5oPgogI2luY2x1ZGUgPGFzbS9mdHJhY2UuaD4KIAotI2RlZmluZSBBQklfU0laRV9PTl9T
VEFDSwk4MAotCiAJLnRleHQKIAogCS5tYWNybyBTQVZFX0FCSV9TVEFURQpAQCAtMjgsMTIgKzI2
LDEyIEBACiAJICogcmVnaXN0ZXIgaWYgYTAgd2FzIG5vdCBzYXZlZC4KIAkgKi8KIAkubWFjcm8g
U0FWRV9SRVRfQUJJX1NUQVRFCi0JYWRkaQlzcCwgc3AsIC1BQklfU0laRV9PTl9TVEFDSwotCVJF
R19TCXJhLCAxKlNaUkVHKHNwKQotCVJFR19TCXMwLCA4KlNaUkVHKHNwKQotCVJFR19TCWEwLCAx
MCpTWlJFRyhzcCkKLQlSRUdfUwlhMSwgMTEqU1pSRUcoc3ApCi0JYWRkaQlzMCwgc3AsIEFCSV9T
SVpFX09OX1NUQUNLCisJYWRkaQlzcCwgc3AsIC1GUkVHU19TSVpFX09OX1NUQUNLCisJUkVHX1MJ
cmEsIEZSRUdTX1JBKHNwKQorCVJFR19TCXMwLCBGUkVHU19TMChzcCkKKwlSRUdfUwlhMCwgRlJF
R1NfQTAoc3ApCisJUkVHX1MJYTEsIEZSRUdTX0ExKHNwKQorCWFkZGkJczAsIHNwLCBGUkVHU19T
SVpFX09OX1NUQUNLCiAJLmVuZG0KIAogCS5tYWNybyBSRVNUT1JFX0FCSV9TVEFURQpAQCAtNDMs
MTEgKzQxLDExIEBACiAJLmVuZG0KIAogCS5tYWNybyBSRVNUT1JFX1JFVF9BQklfU1RBVEUKLQlS
RUdfTAlyYSwgMSpTWlJFRyhzcCkKLQlSRUdfTAlzMCwgOCpTWlJFRyhzcCkKLQlSRUdfTAlhMCwg
MTAqU1pSRUcoc3ApCi0JUkVHX0wJYTEsIDExKlNaUkVHKHNwKQotCWFkZGkJc3AsIHNwLCBBQklf
U0laRV9PTl9TVEFDSworCVJFR19MCXJhLCBGUkVHU19SQShzcCkKKwlSRUdfTAlzMCwgRlJFR1Nf
UzAoc3ApCisJUkVHX0wJYTAsIEZSRUdTX0EwKHNwKQorCVJFR19MCWExLCBGUkVHU19BMShzcCkK
KwlhZGRpCXNwLCBzcCwgRlJFR1NfU0laRV9PTl9TVEFDSwogCS5lbmRtCiAKIFNZTV9UWVBFRF9G
VU5DX1NUQVJUKGZ0cmFjZV9zdHViKQotLSAKMi40Ny4zCgoKCgpBbWF6b24gV2ViIFNlcnZpY2Vz
IERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKVGFtYXJhLURhbnotU3RyLiAxMwoxMDI0
MyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RvZiBIZWxsbWlzLCBBbmRyZWFzIFN0
aWVnZXIKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJC
IDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


