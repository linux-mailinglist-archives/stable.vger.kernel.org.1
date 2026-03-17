Return-Path: <stable+bounces-226885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEaON2uZuWn5KwIAu9opvQ
	(envelope-from <stable+bounces-226885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:11:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 779382B0AD6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 050A73088249
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D035A39C;
	Tue, 17 Mar 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="qLMklQN4"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B43280A21
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770389; cv=none; b=g4iXIIzwjsMezn1hAhEU8Vdo19IOC6GV+qJgH9jJon9vUP24HXZr9S5LRhQOxmJhtsSkdRz7ouyS0SlCsxt8m8M/mrlfQCYPUrTnB2TKyOZA71Aq4D33xdNiJAHevl9DJd5SuYDRIngH7aSVmw1P8zi88HilPUHZfiS5ZjuRzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770389; c=relaxed/simple;
	bh=qEp2sShqi1KgMVodMBiFhJfJPmr3G501i0+Nsr1r/70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUMhGwszUHBj/xkcD8EwMbwWttA773KnNW8sJveSOsJ0eIGwB309NgtWy1FnfdkNcga+iDAKIWqb8GLM+L3AWZ+GnvHi9a2DgYJMlOcy+Q62hwnMSGXowUQa+wZE4juvWVs+ZKi864+eZzn8LTyJdNUibxrGQgfsjQqszcM6N4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=qLMklQN4; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1773770352;
	bh=dwHf63CrmgAOF+9cH5aTI2NFbzmXoNuZgytYJc9T92s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=qLMklQN4ttGaVptIbhTIx66s/6/6HY6NQVt7HZFCq1O5scxI3RAFxoXSaaaQ+iPA4
	 nfyDgeOZ8aZjLHJuZNhQSJkmpq8axN6RAIKFEeSjKpPyLBo9Dp0XLIArjUwmUQEoh2
	 EMpgV38b9rm2ixAzsiu/WKHnOfrrOVIE1gukGm0k=
X-QQ-mid: zesmtpip4t1773770344tea1b4c30
X-QQ-Originating-IP: K5ac4WI8bp9cfw5clapaXR+RIF/6/c4o9JrjhC6KjGA=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Mar 2026 01:59:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10242624894791450285
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: brauner@kernel.org,
	broonie@kernel.org,
	davidgow@google.com,
	gtucker@gtucker.io,
	patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: kthread: consolidate kthread exit paths to prevent use-after-free
Date: Wed, 18 Mar 2026 01:58:12 +0800
Message-Id: <20260317175812.707723-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260317163006.067634764@linuxfoundation.org>
References: <20260317163006.067634764@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mxh1r6NAWu99nW/jZC3dpUcMpD7RfQTxqIU+QF4jTo+jlUdm9ePbplyR
	BYL6VUQPFwJvKj9GXRDAIstUyy1+Qto+e4BRrriYhJKRn/EWJlmOiWk3B/R4FcHOUcikjO9
	qpmDH9JaBNvUQoNujS0ULDc8xgSOJ+91PzbA4ZcIG+CdQ7c8PKe+ExUlqHFZTRyRY2ghB8z
	hFyKOZvI3LTeml04c9Y0astnfq+9I4y9UU+NKsFwuS1QYtxicD1jaA8hG+H0gcaGJWBxLgC
	4hfEVYDyI3RxSyjZgQrq//khLXkX/cv4iOdlxmrEsooyuxPnQt1asim4EJZCL3A2XJkunbU
	V7ymVZt4EIYBGiTHZDiSWXTzIOZthgXFxnKSrveix0kfGvrRZZhDqPVQIyamyT5ON94OCfm
	5jkQXG5epBWc6ILN9XgvQW45jx0sLyM0dV4R9uW5nktVquSvvZW9TUjeAzbXmQ8Nd0SM3l5
	BxRshISt8qtYIkMGmnYlJDeqGJ3BTMfvr4SXa0oPW+z7cN1AFaaxHHHqZgzHzcEPntHuLPk
	SZ4Z5Ak/Xc/2nsHXjF5OT8mxGUwz3/dK/ZiNspSBkuW9Sny2oDI8utvSyDoy5X9dWc7w2Gl
	3sYBSGRzph20y3697pj6ox0Yc3Eh9LYHGxB1SeSHOV0ZceMfJ1MEZBvo5w/WC0isDqqhvn9
	4ESWQeIwVIDDpWfjFoufQyZo/IiL7vEHEtZyOJZyTqi6MB6PJGIKz1t8ViJhYBNi70WdjIp
	EughS6OGgljbNjuOhjx3q3aL5hNXp6rvUBzAyhZTeqpDns77hzhJtW6G36LIA/DVD+8m5Ca
	4UZO6A9kQXbUqFtySCF9WM8CjcWSVdKaMDpvWrwgU4kCA/XHxIIwjWrMpmp3T34U+N4/N4c
	3p8kxhWRQW9xcDl8ysLuOsN1G/rJ4v4rB3JErrsqy43XF61uKQ2ZI05A0/28n4ap6S5m0WI
	WppVFxHK9J7zR8yCzR2jq3PXFPz9GY1ezWFaFOVM/9EWPaOCUdmz4BuvgodBYLEkQ5ACkV9
	G5WCK/0jNEsZ5EpEMl
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-226885-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 779382B0AD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I want you know that need backport ("bpf: drop kthread_exit from noreturn_deny"),
which commit 7fe44c4388146bdbb3c5932d81a26d9fa0fd3ec9 upstream,
or will met "WARN: resolve_btfids: unresolved symbol kthread_exit" to cause build fail,
I test v6.18.19-rc1 with the patch build ok for me.

BRs
Wentao Guan

Log:
 AR      drivers/gpu/built-in.a
  AR      drivers/built-in.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
  GEN     .vmlinux.objs
  MODPOST Module.symvers
  CC      .vmlinux.export.o
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  KSYMS   .tmp_vmlinux0.kallsyms.S
  AS      .tmp_vmlinux0.kallsyms.o
  LD      .tmp_vmlinux1
  BTF     .tmp_vmlinux1.btf.o
  NM      .tmp_vmlinux1.syms
  KSYMS   .tmp_vmlinux1.kallsyms.S
  AS      .tmp_vmlinux1.kallsyms.o
  LD      .tmp_vmlinux2
  NM      .tmp_vmlinux2.syms
  KSYMS   .tmp_vmlinux2.kallsyms.S
  AS      .tmp_vmlinux2.kallsyms.o
  LD      vmlinux.unstripped
  BTFIDS  vmlinux.unstripped
WARN: resolve_btfids: unresolved symbol kthread_exit

