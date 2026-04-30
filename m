Return-Path: <stable+bounces-242151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLS/EAJ682mt4AEAu9opvQ
	(envelope-from <stable+bounces-242151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:49:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B104E4A51AE
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAC07302CB24
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE144CAD7;
	Thu, 30 Apr 2026 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iwo+M3QG"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEA44BC8E
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564154; cv=none; b=TG8Z/miK8iAHx50o86nF0TDL0nnNl5TH5kLX3eKDVv+gkVaDz+Qipp6wvg/1Zif/qFGdPglCZMRdkzXqWhx52IbS7m6IvcH5Toat4kgILI5ib9eqMjFIeLMpOJpSGPWWvQXn0fgxqrmdDOG11pUKU1gVOEdjc4HgN4jfHaYXBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564154; c=relaxed/simple;
	bh=B/A6auNUdXoDwC07h8sgrRFpq8fcdichT8Vqt7DKumA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CldtAgz3vZ09yITiU6z66lu8CThVXAb5DM1VUMGwKf1mIeCXzx1DRjCL6nA3SHsNQtGr5ig0a41Jew4TeXgIMIsn+JtU5sHQ2IPTzFI0aux0qhwzd2gJt2WR57krn009DbyMw/zBoydmINq+u3uNtW61sczSGg8KO3hqRQxsV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iwo+M3QG; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c92e701f-33b5-4f93-8e09-86e36e0dba60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777564140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sg09exyfANbcZe40eI+KW434RgIdCLDQC6dSbNk1QGo=;
	b=iwo+M3QGC2+aMuteqpB4XgW6PETfC0cCr9y2vztm+qkbtmULLim0nNf6RuqKALI7mS+leu
	8AuxGb9IrFAvcEaK7MaNC3/Y928kGYbEpIDL+0W47Ou4XaxHLwN0F1nzg5StOBkgPvxPat
	kB96ryqGmV3ZJdx3aGv9tI/uLp/Z3Gw=
Date: Thu, 30 Apr 2026 16:48:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] bpf: crypto: snapshot params before string validation
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260430043404.58221-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260430043404.58221-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B104E4A51AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242151-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]

On 30/04/2026 05:34, Pengpeng Hou wrote:
> bpf_crypto_ctx_create() receives a BPF-supplied params pointer. The
> current selftests use static initializers, but BPF programs can also
> build the struct in writable BPF memory before calling the kfunc. The
> verifier checks that the memory is accessible; it does not prove that
> the fixed type[] and algo[] fields are NUL-terminated strings.
> 
> Copy the params once into a local snapshot, validate the reserved fields
> and fixed-width strings there, and then use the same snapshot for all
> later checks and crypto API calls. This also keeps key_len and authsize
> stable across validation and use if params points at mutable BPF memory.

You didn't answer the question why copying params will somehow help?

> 
> Add a selftest that fills algo[] completely and expects -EINVAL.

What happens without the fix?

BPF Crypto follows in-kernel Crypto API as all other in-kernel users.
If there is a problem in crypto - we have to fix it in crypto subsystem.

NAck.


