Return-Path: <stable+bounces-212743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UADPF7QLe2k6AwIAu9opvQ
	(envelope-from <stable+bounces-212743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:26:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E1CAC937
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0900330177A0
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BE437A4B2;
	Thu, 29 Jan 2026 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="cPkh2ca5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941037755D
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671599; cv=pass; b=DVOoIGHEgPricN6KkS7LPb6CaEPUu4SNxgnWxe6TC+6OtF2f2DlnEXyeXmrVAlt8qKV2UNrW65csKvwKkpI+Fq4lNKvROtFv4bWWFBT7eNd1Rcts2Llex50OU7Hc16xi3LPQ8/l0BGNkXQQKYWUe2mhNZ+PhrJzUSTU1LSKafl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671599; c=relaxed/simple;
	bh=jIcf3bftWePrHmf6DJ4EIXKk+IWCQqI4iIAaYVOEp7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCuItex0CKwLsDyHeEhwO0QWxdhmUroJR3xy2pyeZKnTTDLBXq67ZQcWEahdSsZNQjnVT3w1zmcM9KxMl62KD07lnW3+Y4eK5Y1oJuTzvdTnHL0A6ggwxjx5JE2Xkpie4C/3dIRC0qHTDPEqTx7NAuChTa8monNgMtQeJ3Wd5uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=cPkh2ca5; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so878120a12.2
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 23:26:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769671596; cv=none;
        d=google.com; s=arc-20240605;
        b=Jfd3+vZESdx5kZEYO6Cf8/gP4RtswZ9Ll6SpDdj7ay1/9wHJ4QnYS+NyG2WzjYdnrD
         PWq9yrw+s6j7gZRzIOsZfvVIQa/1z1+Hg6TT/Eo3sEpEoIvBx9jByG7F2ffxZKuOaDbQ
         GZT9ILz2QbNV8sTL0mwuWaNiEsdpqgzI0KEF3rZFfDBH3cm5nlgIGUqSO6gTBfCuKesu
         U26ALWNl5dELFMZ/49NQoBbnkYluzEnXhTe054HWW0iCPpZI60mPAuZ1g/zZpskDyS4S
         o6WUiMUpsIs4j1waPjv4Fqs4dxeXhxLpy6aCtOAPDcvTPxeTtI61BA9YnUQ+p9lhhpE9
         cBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ljkiWEP4qXD4UYOQ7xtNSIQF1spsEIF2QfMVOCI5eSA=;
        fh=Y74f01YznQtICCoVpDtu65QsUfM3VPu5xLIo3JzpQ/I=;
        b=QFzaAgvbxNsZ0IyNacnYAlvrdSBEPA977VNhxt5OB03MEtnnebLvaqdwolXfW0G+1T
         jVmvClN4zLZ4kctb+3P0sysAaUN6tLsXOsnKC6jiK4RqwBkkRi0bCjemYHpYSI03ApDD
         4joFPz2wNnghCGMs9EF9ufXwCAYv3y3aQhxhFk5txe5eUI511FsjcLQ2DC8XUpzgBd2c
         ftIyjaLPdwxBYhxGEEI5cYEXhtmBpHXvsVNZaGGXHDiZMGzZmOUypxJ0ebuR2yXohdH1
         4wq8WcD4MuXUpD4gUurBu/DbZ7dAwvTiBHakFz15Qj9pb2mrc0IBR5C4CkNFFvTLAtHm
         zSzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1769671596; x=1770276396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljkiWEP4qXD4UYOQ7xtNSIQF1spsEIF2QfMVOCI5eSA=;
        b=cPkh2ca5TgqKPz2UvmpeX03s8SPcawygnXDlo15djYIFhbVqG/ZeytQEn+bIOUqxBI
         9Rf7AVApDeBi2cFuM87m6bp/MLBuoiBYV0qz49YnfScBcszOyLoSiZ/5cknOn8RumHK+
         tS4ZK7Wm5rOn/P6cXAqIHyfuyENpENudaYyHlfUK/1B7PYLFLS1gl/mIv+qJnrUICK3q
         cTKBXKnKpnhy5LraOTavw+DGsXjzePMS70rj3L1Bb9M2fBBFbhwPUIw8jSMnALBeJM70
         G+jM+FSsJcQJGlbx2JIORfo1kkfmsGbVim0PvTrEZpVK8VxvaJymSQ4T8elFOqS+RzYQ
         Lw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769671596; x=1770276396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ljkiWEP4qXD4UYOQ7xtNSIQF1spsEIF2QfMVOCI5eSA=;
        b=K1ge9u/czOcyNontebQQr9by513H7br6eG7/UiwNVkRIMxNzzLoDS9pA8VWRXG/YZY
         u3GZNDEVCfU5eF4c8tBuma4A4pqnJIB3o4a2vaL4pOE4DFNYvMICm50kZTK6QGfqJDUu
         LZ0t30iSKtofdKneKqYUDXwZMVik+g1nTCJgvttEU6KoEl3vAWAj0jtBScmqmJCnCn9C
         E1erqTUoeovdhE1PRPsuJqhh3NivB2JNQTlpSEtWExEIMWr+tyIOioyUZnk3uviLqnCy
         JLUTKm6P7HxJZ0t0a/ktbBbrMliaVH3bio605KzTqjgj+pzp9/W6tzXIcWGjCawIYOE2
         1Y+w==
X-Gm-Message-State: AOJu0YxAuYfNQtuH7vERMqAfwjjCkeFVjtEwqd6HgFSQAX3RlMFz3Jkp
	ad4sZvMf+/o+scM926fW19OPJJu9eUsysdhQtMZOzSQa0ivx079Zoy7xQKCMo3U+k2+L04s9F7O
	EjiL/COrizMBoPxKB4KEliFNRtwGJXO3Cesjp2TPaIxEa59O5IeEZfGNF2W/N1wBcGPirfKs++t
	80CUsIDc92kV3ScHlVLDm6YhMt0D4=
X-Gm-Gg: AZuq6aI5B0LUZynQzsl7ZkgbTIOSlgrDaKAbuldxAGbCO/c8BZSmcTlFQBfze30oaKh
	HNNAUihd8KoQl/uYOY/thbUrnb05Rxpt6nQlK9sOywCkXi9+xjN2bijqKLJKBVYMQu96+RA3SXH
	d1dD/OcNu5FNkUVTiddHXUgjkKvCWAnaV8BM09Z7JGyBd4pAPtu9JUS+Ye2/zqAHWG+LoVCUrjT
	78zy4zSQ3k0F72+O+ide9YR6Ql/dvUyhb005HjoDbAqIO5EExHfj1LW/ppY+4cmazBYYUWixrLx
	OaeENh0LxGry7BVX9Q4kiHqq+UY=
X-Received: by 2002:a17:907:7b82:b0:b84:365f:10b9 with SMTP id
 a640c23a62f3a-b8dab200c34mr506078866b.29.1769671595980; Wed, 28 Jan 2026
 23:26:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128145344.331957407@linuxfoundation.org>
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Thu, 29 Jan 2026 02:26:24 -0500
X-Gm-Features: AZwV_QiI4Ro3fL7PVepzGSK-70z9zucZj9JGWpLN-3qcg9O2eCCDqdTxO_N1GwY
Message-ID: <CAMC4fzJ8jETK6v30L9FFNDu5rK9w20kwn-F7=QbQxyLVTD5-jg@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/227] 6.18.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[sladewatkins.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[sladewatkins.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212743-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sr@sladewatkins.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sladewatkins.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sladewatkins.com:email,sladewatkins.com:dkim,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: B1E1CAC937
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:52=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.8 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Jan 2026 14:53:02 +0000.
> Anything received after that time might be too late.

6.18.8-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

