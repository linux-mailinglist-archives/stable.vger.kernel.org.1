Return-Path: <stable+bounces-230543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oILjEg7FxWlHBgUAu9opvQ
	(envelope-from <stable+bounces-230543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:45:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DDD33D302
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B3293048475
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCEB33ADA3;
	Thu, 26 Mar 2026 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nETpCQ0a"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9330596D
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568713; cv=pass; b=VZ5ydl1G0C95pk00ZDNhCILlS2MlVKK7yVozjCQrmpdc9+LVGfDUv8/IuXtToZsVQfghUElC4ZJ2GVnKuLfo70kzQYasTH1TBprGrWth8unNp4IyGx5dVGBeQ7mxg3K7w7GwQmdo0UTc6p96y/DoEce/N1Q6j27ZsBz9DPW2Huc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568713; c=relaxed/simple;
	bh=xu6RA40b71J8Rif3fpjESEdRpXu7mTJtIso8FLjGmfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=steSNzmdT7+g14You7Hznr1/Uk5NyeY5ZO+bra9UKxgFpV96PY/LCKpw8hY7tjSWsD8YyXsCy6KNmqUUlXGXJLEGUcDFExBvKhb4kegbMnCxWNsFl8cmHAT3N5/Gs6FDuCm8vPL5Y79SuMgqjEM88uC84AtKAI0RKI0rXMrpR+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nETpCQ0a; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so2127751a12.0
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774568710; cv=none;
        d=google.com; s=arc-20240605;
        b=eOM6FhuTI/fJWuDOVHQ4y9P8g6O/z6lksP54l4sQ86JP5SXSADRb64SbSvjsAABgWt
         QRAMO+wmXC3C6W/FyPEWNXqZ18LXPSIy3FVBxIMSNcOULszgxK2ILZoDIRp8L3EDZ1BD
         ShwVHpiSCLE++cusex4pfoft2LwyihxvZIj0NP4YDyB9iJl9gchs7oANCoYI4BEO9b88
         16d4Vamh1+2A62rbVXHYcE9uLP1H01fRdj2GuRsP9GWJZbGwqQcD5O2MKnO3nOohMIq7
         i5uoklqZLbcqEplLy840hT2VzwqUctNpSy900Y0x+F/9U2OhkQ9vPMe/Oh7ZKKk+pmW7
         4PVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xu6RA40b71J8Rif3fpjESEdRpXu7mTJtIso8FLjGmfE=;
        fh=zBYe36oTKFvq2Q7nFl/OJBlKLrmYyAxL1rdG+VKDKgY=;
        b=FMxkv0fv6lCuKP2fZFEn0mV5FD/rlh8vc2IT4AeAHm0rfvk5eHJBagQ5iXTEOEvNUJ
         VIiq2qefTdnVbbDkDmv05SnWx8MIANi3gX+KxbDZKmrfk3TjyjVRfTxylTZv/AlTGU5+
         q7DIJgePzJ+XnPTPDyvcXTm99sV/TE5cJDxXeolYRx0L80ZiRaq6MtB33YY5VbxS7lbV
         FYgwhXLASvX0CSFmUM3khFudsM740eusI34YJGnKhUa29cgiVpluDxd28aewGYGHnKgt
         BY9G7h0jL5N68kCOQDDuNXCwim0ZMZY5S4P1WgeJ+k9wQAL5LWCFMgvng6j9gkLgNJ1I
         HeGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568710; x=1775173510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu6RA40b71J8Rif3fpjESEdRpXu7mTJtIso8FLjGmfE=;
        b=nETpCQ0aUfqdzCavBwXuOz16ezJK01EerfGZc25TPsyMCMPB8CgeGMmJMqNuG3Pylf
         zdI2THWzAWdH9DLTV/TrfFfttv1SNvDvRWSiS1LCUoIWhwAigHxhn1yVCkqfG+wILOTZ
         ZqHCg/0naxg79ziDgYFMyDsBQCUBBOxTtXVLbvrh/XZeL5Pzr5Pdatrbb2qe6tDO1nJc
         s2eod21g3/00UprWPeq5DiquJVNv4zQxf4OF7hVzDM21lNSjTm3nHlCoB23NTMSJrX/a
         Ub+t7vsg6iJEB3JUIw88yMYpE23q07LisiQfULGnkTMy43XC753oVx/NtAzFtaIiP6j5
         nVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568710; x=1775173510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xu6RA40b71J8Rif3fpjESEdRpXu7mTJtIso8FLjGmfE=;
        b=WFLhzS2+iY48eNruy6Wh5u9y9D7ZtAU9Fs7muEw545U6hsaXzJVAojiW5UIS6dw+QS
         yUzUmKN4IUE6K6r8eVqX9JbxvHVAgTN75C3+mNPBRkB2VGzAznUJ4JqfoK3j135Hu+f5
         PEofj/NTorOJUJzIXJunuomgY4rA443nzSBzGDvY5YxcWSGaJn/nGrrRsmZSa0ojTmmy
         6bjCr5a6BSeNbQr0DPDx1O+/h9LF+oGqJhk+zPQHipzXGxsOkrV5bZg8ypHRzCBgl42u
         EYUqemx2pwXxHj9/0F/i+1X3IueTyTvrP0JUwRKAsFMvHCTmD2xOcz1hYoE4rAOOTVm8
         Fhcg==
X-Forwarded-Encrypted: i=1; AJvYcCXLPrvJyiMPz8T6NYr3lSYUSjQEgk5F/42RhAuE8O3lxCPsfkXBBthFKtLS4jc6YjhrbM+0lV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Thc4PgkFNlAhkPzZvAQnbB7eJbJ624MMwK92+pKPj/1NOatl
	Z2Qw1lDZgBYhZ4MnnfV4GnGDVFGt9JpR5pwQzm1mNJVYmIxez7PGv8722b0rEQcHfCRZFUhSTED
	mK+cDYsVwQmQDAp4JpU40o7D/wCzJeUc=
X-Gm-Gg: ATEYQzz7IstOPF+XKLZ18nLPt/V+PFbv0VJZ2W9uV0v0eCObjLF4qimWsCpbC6UrW+V
	tt8euew7GlDomOnnAMbgWPmofEP89G8aBkSJjLAneaV3JAp7/CZonsA6XJGWFFK1H+zrRVMGGZK
	6XCGM9ZEJU5Jo5nNkY85pbXaxHNFfkJPYwL7M+DR/6Pc1UXPRtWDazH6fwkoPHr18DzB4KZ9jyd
	U7J741BIs1OaJ4jHBV8oD1WQd2TllRCbsqAqfvNdMgHE6iTb1DaNJrk8f16qpiJVbK9okwUv+ze
	bNIZqIvi70p+4gVhjQ23uuZR7NLHNSFwHKPE7Yk=
X-Received: by 2002:a05:6402:504a:b0:66a:1744:5cad with SMTP id
 4fb4d7f45d1cf-66b2826a13amr159250a12.1.1774568710090; Thu, 26 Mar 2026
 16:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326232130.1891210-1-turyshen@gmail.com> <CAGudoHEHua4cA2-jZ0Yf54LQtuG_7=We-EMcW-yriNQ5JZzM5A@mail.gmail.com>
 <CAHLHtjzi5uKrNDyjL60nZ6TUZnae5gDaEHL8dwbMECBT1L6tdg@mail.gmail.com>
In-Reply-To: <CAHLHtjzi5uKrNDyjL60nZ6TUZnae5gDaEHL8dwbMECBT1L6tdg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 27 Mar 2026 00:44:57 +0100
X-Gm-Features: AQROBzD_V8D67SE_uwwGOkm1mH8cRd0Q8DyQyiKOH2Yauo2cvJ5p5x5nir2qSYw
Message-ID: <CAGudoHGT_8fBCq9BORhYqt5GN_rmWh_MY62ZMouSGqhgyaD-iA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: fix deadlock in insert_inode_locked() waiting for
 inode eviction
To: Xiang Shen <turyshen@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230543-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0DDD33D302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:40=E2=80=AFAM Xiang Shen <turyshen@gmail.com> wr=
ote:
>
> Withdrawing this in favor of Jan Kara's ext4-side fix.
>
> Sorry for the noise.

It's not noise, thanks for the patch.

