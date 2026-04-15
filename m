Return-Path: <stable+bounces-238010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNmDL4b53mmVNAAAu9opvQ
	(envelope-from <stable+bounces-238010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:35:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5343FFCDE
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5795F304227B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2783529827E;
	Wed, 15 Apr 2026 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoH9tTD3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF623D7DF
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220520; cv=none; b=XHEBcTqHfsguusslGBjO12l5NNyYC/Tul0JsE5z3oMZMvavu4jwEQYBbluwF2J0524cUjHNfTMvDgSUzTjX/jZaA8gXb34ADIsBOk7TAV1peO8R/r59o2k8miSGlNdSSH8MSXwKW0x76fhodx4m4o0x0ks6RrZfl58HeQsUNfHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220520; c=relaxed/simple;
	bh=xeka0KvmW0KAbHvVDC8a32jlEsRKOARSuGKLT5F++WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7sUiUdd9rm9o6VMHDRHgGOhoyODPhrQxNkKPgroLG8eHV1keKPPw+mLH5MtH6p4jeWgFU1lo9/9sdW6EMJk4XT1fnmC/D30SSgTBhC9yrj8zmkNwML38M0unSOPz6cumQtIngj79H9p+CpdktPFx1TIADFlCUVwnHFSSlcqZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoH9tTD3; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d67a483d3eso669126485a.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 19:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220519; x=1776825319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9Ioi6yU5A1uj8bvMFYiWNJa9cXrvuP7hFHZqg7DVp0=;
        b=SoH9tTD3/2DPXifS1TJTxhDPmfHMKMXZZISEiQDuFxepqYU6UpRQiFV1qnmxXW+Vfj
         RsopHXJZ3zIs15n/AgPUtu6TqhaobGl/yhaUD46g6g2BMEb5446e/7Yn0+AKWjh5Fruj
         tVRj+SOKzmKlG/PJe5t3+aYh4xcIXtsitBEqKLZbJFGc5RBt2rfpysbxnY5DU37lIQnO
         FdWX1WKlLIIc4pH++qUdr355QCD0iG48ts1j2bbO/yb5fNf5h6FGAc5I3Blve+6b5xH2
         0ykxlIFetIbOndQxjQ5TlUuCijgvDXcG6XU8CnL1+nylnnmveFjCV9t1uk1eseYtvmCa
         wUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220519; x=1776825319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X9Ioi6yU5A1uj8bvMFYiWNJa9cXrvuP7hFHZqg7DVp0=;
        b=q+97R5so5t/NjPhJo7HSpsiuneICQ6Yd2q5KljO2QfNg5ctm6ybIiAnVMOo6SfoaFi
         G+CTvtkhqQ/1MoCsd7ttAE0VhcWo/zV/TMZ2iGywpOgCoD6jO1DGDxmQ99pmIjvRjWtu
         W4zMSBo0qQKrMXfIb4rHBwAMBgjd5RRK+gQy74a8UwplERfwhHvhKZiBfXPShFTMNAy/
         ib4mErpAajIhG4pXe9jBS8UW66hc6Xvvg9wuPhFoHDcLHvX+nR/oWB07EYO+sWwPDbS/
         QFuSosdNNM7jlxa1KnIFVgq8I7DIb6PyY30QXw5hVodVTh1ovvBzMw4+J1ocLZEVtzbJ
         FAkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PtKLyyZgL4kLTh++yrINhEmFPRfYS/sVXKe3sacNXGi09SqtLbh7g4/zCkzC8mz4v6Ao9pQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WySXe8XDui6BQjNCefNCJG27/oOpD+kL/HQSOJDxkieQC9Ck
	w5DYkIYjIbIMsspMUvbAVx9I6OvzJX4342uphpEm7lRft90+AS8qs2hC
X-Gm-Gg: AeBDievT1d2OPIkcJKMZA3sO61LDdWeufXSYFrb0xQKyKTPZa0de6Mr4OB9kZ8k+L9Z
	EPhFmkuy+tqddNRcP5LT14A/taGcLcOCyUcoc8gTBc+qMVtvH274om+pYUhV/uZcMjJkCZy9Ur1
	LUsRfunjJFP1lElwfEgxxnxUR0MMJgDYII/g4mFv1kgvhi4SV17ASkJfR/D03fSlQEArsfLBPdW
	mY/NILE/9jmFnYMKpOt4eBMgwQcp3PMIFIiUCePNAfIXw5SUNDIZHpblZiW1dFL3MAQx5E6ZeRH
	gHhVdHR0vzWbzyTIna3JxeeMSBBaW2T2bRVaf6ERKrl71MIbV62oJGWEX0rgFjZ7hUlL9KSu7tV
	iM+SO3vgyo1dPAmI5ptla4hxKmvupTHs3ItgR8wlnIa21CdpUwPR2jRnDjRJgrpZ6uc9InbM23R
	Vy1yKU84nUHdz3GFTuRzDZEuYtGrt//wwgyKaR5WLNMLrR1ccPBerOwTfxfwdJdURAZFGxx2hu9
	oUcfOQSinbSbiUwaYVdZh3EHag6bIM=
X-Received: by 2002:a05:620a:4606:b0:8cd:7271:65f0 with SMTP id af79cd13be357-8ddcfbafb9fmr2772166985a.44.1776220518435;
        Tue, 14 Apr 2026 19:35:18 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33bc4csm23957085a.12.2026.04.14.19.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:35:17 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ksmbd: cap response sizes in ipc_validate_msg()
Date: Tue, 14 Apr 2026 22:35:10 -0400
Message-ID: <20260415023510.2659606-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKYAXd-zwPuES8PdV+XQjuQUemVKejayqY_0aYS=88uZ=FG9+w@mail.gmail.com>
References: <20260414191533.1467353-1-michael.bommarito@gmail.com> <20260414191533.1467353-2-michael.bommarito@gmail.com> <CAKYAXd-zwPuES8PdV+XQjuQUemVKejayqY_0aYS=88uZ=FG9+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238010-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chromium.org,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F5343FFCDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 11:00:58AM +0900, Namjae Jeon wrote:
> However, on the userspace side (ksmbd-tools/mountd/rpc.c), the DCE/RPC
> response builder (try_realloc_payload() and ndr_write_bytes())
> dynamically grows the payload by 4096 bytes using g_try_realloc() when
> preparing responses for calls such as NetShareEnumAll, etc..
> This can cause share enumeration failures on servers with many shares.

OK, thanks for explaining.  Sorry for missing that context.  If you
are OK with it, I will send a v2 that drops the cap on RPC_REQUEST
and SHARE_CONFIG_REQUEST and uses check_add_overflow() to just
prevent msg_sz from wrapping.  The [0, NGROUPS_MAX] bound stays on
LOGIN_REQUEST_EXT.

> You don't add the check for KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST case.
> We don't need to check resp->session_key_len and resp->spnego_blob_len?

They're both __u16 so the sum can't wrap the unsigned int msg_sz,
which is why I skipped them.  Happy to add check_add_overflow() there
too for symmetry and clarity in case anyone refactors.  Just let me
know which you prefer.

Thanks,
Mike

