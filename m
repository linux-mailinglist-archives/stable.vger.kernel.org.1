Return-Path: <stable+bounces-223271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALBwIAXnqWnuHQEAu9opvQ
	(envelope-from <stable+bounces-223271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 21:26:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1696721820B
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 21:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F364A306223C
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051A338596;
	Thu,  5 Mar 2026 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjDpAaHD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C73358B0
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742381; cv=pass; b=ohTaoEAUauM9XIyFo1Hd2nYPOSLn/vYeh5wC3j2/lPOqyn8Kz7fpXsucx54C+Czq8JS0Z4ZW1jsVN6v0sIPLsZh56F5XHah7OoEvH/tw9NuYW66jRxjXxC3q5vBNnE0mehxKgtNv72HCjDa95t+FA3bmlIQBtd9/D5NRJ7Skj/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742381; c=relaxed/simple;
	bh=Pvq15S5nkYX0VodoVEjZbIiwXiNDRMBPvlO/0D88DXE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Uy0qmPb2U9NN0RM79qy11xujFIPF7tRNvZ55tB6SshZHa30YOQzGMasFBrPvO68u/jGmVwQWfDLC8+0wMw9BY/0TNER8pnaQ5JdXwKcL2cWT/5QJ3kfM/YFegOjXnmsY0JvKU5CDaUUsSwAMzDbB+zy4cZIGXZUCoh9jrTZjhsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjDpAaHD; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b941762394aso98255866b.1
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 12:26:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772742378; cv=none;
        d=google.com; s=arc-20240605;
        b=c0GlLnJh7HvDgw8KLHjb+DlG6062MJSFO0aNhUfbCnJQ8Yqxu34o1NQz7L6JLKUBlk
         r3RbSQXBQ+nBXD6vR/6qo4R9lDNt59QpdlhcGL6vJnEuqU8u5SL033yqmgvpFNgc+OSD
         gqpX6G3D/cov3x8w7WkhtLX/kj8CpEYnis0ctJca3fXmOKt/54P2jZ2IAdnclZiuo/a5
         JTcIjG62ySFZh2whUtUPDFYcOYKMOZRvsb3gCNWj7gWS0WZOLPX467O9ogWxQW6M+cvu
         oO9Mb0yG2anlKpHVpbmVk2dcG8kR+ZY66F+dDXYt2OK6kkmGCkB4Zp8YXUtw0fERv6X8
         UT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:dkim-signature;
        bh=Pvq15S5nkYX0VodoVEjZbIiwXiNDRMBPvlO/0D88DXE=;
        fh=2QHtHABnDIcrqYd4iHG8rZxKEbuCfg5t4ZseduPVf7g=;
        b=ANRq0Y9WnuacumlY58PfYNrVLtHRi3f5lW+jZ4+UP6K6/GVQiw13gZ5QSo54YLUp/m
         rsJxQAo8SAuEvpWVhrWXWlA2ajHRCNasxG0EuxDnYlLdioYed745WJupbh5AGNwZNbhl
         YNhY+ROE1IRiIdVte+De7m+il9BnFdQLoe5W/Vu4FTel1czQ8mYvSCRzx2sat+3sd7Z/
         lzA52ziQQZUpj8KDlivG/O+DQDrHDKGU/gr59I0zioWs4QLcCa//Frj3138bOmqZDmPk
         SIuy44Y+FfIfuCXYqPMla09DiH+ABe5WNFc9pmlrcI48UkGdb6duH5TnkO2IofaH/HWU
         Kxtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772742378; x=1773347178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvq15S5nkYX0VodoVEjZbIiwXiNDRMBPvlO/0D88DXE=;
        b=VjDpAaHDC+gkbFRgD0WjlLwBboHj0SjHS8xUTAH5danwC7dch1vonSm/jKnLehuSuT
         zP27b8neSDofig3mRxgsREILV29ynOhSFO4F6gVhtobzCjmxBjVB3AnZ1xyOzG0hEJc8
         EnO3+ZiRs8MtKNGbfNk8LZGgVq2phE/g9R8WpBx/CKfXJQ1xyNZHROFVTuIPLAMCcTy1
         us9xtWFJha+l/24/zmnt1S4prIsrzsjNxF+m9uLpjw2IUly7tKRSRenNAJpDWsNe0CVZ
         xHuLhkYE4aKoFq+ce8nclJupu28erWowLbTZaSj9D3KyhHG8qMU5RBu9cn+7PCH54jZ6
         gkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772742378; x=1773347178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pvq15S5nkYX0VodoVEjZbIiwXiNDRMBPvlO/0D88DXE=;
        b=bH/14bw39683Gv/zmX9lEyCho9MJjsiP8MNmTAflvJRsDH+zfMRH4SBxG7HS8Y8uU4
         U9C92rxrngbYnUFGCZrhv1E+oMdaRusV59roELqvooQBNNOc0AQix6n4myTq9r/wxdPM
         H4Ugcg9312c8HPPyY/uelA8/gbx3cMudFl2Cm1YUOylpOrzpkzX3GXVWlBe+9Rz4zbiF
         Rw0/X6uFV0ZUKvXwe47goeskKUyp5ge8G3EmHd2UFZ5MqadtLunhzgJ6sxVt7FiU0gZP
         P8Un52AosedYUI602SzgNNUtvlxDEQu/XvcYrN8JUsB4EHAhXl84snAtFJs9Jy+yxalv
         Rw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaUjiXF1ibZv7kIlk+R9AeAjC9t/YuXZBfqCjSEbknI4FhckpysdN9IM1zdje1fP/z3CS3kHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkh3Cb22QP5ZgPled13phGo95i+YpnUhdlaqLjABIrYkcVx0pX
	cUIzusdZY56nTgPw7HKHQCV1ELHFppqhrD+Kz8rwe4yBODl5iZUOh5qEAkx2dQ5eMX+N8fAY7Bx
	9ot0l+D5yHsHs3ahcg9MzMZlzzcm1W2s=
X-Gm-Gg: ATEYQzzHlnaO2mzDwc38LoAEwoN8Gz4P387dBvg97A4+r3+vhD9zXXmR4Gvhe56efxy
	sHLMY+Xo3ZfYmp4S9AV6dF4kybyt2iVOaW461eJ+9xHMgtkh3cwn3B2hAqNlyHAKABhO0rvzXWu
	5y5C+8vyQRvT5WWFwMzAtq7YDbQNZJCWKJrix/CS3ZiBBLeMNX77jpcCHi5CANv+qnNzfS3R8cW
	0bMOKDLaAJZUsVFMRvwJWawcXUqdeDZ2XxYYtDxxQdzVl96vMoof966fSjcU4+Cg1Ke+A+AJAbz
	xxls5fWEl2WcelbYGV90UofYt4xj09Za+1QUE7O1phkAQogo5g==
X-Received: by 2002:a17:907:6d28:b0:b86:e938:1b26 with SMTP id
 a640c23a62f3a-b93f11bf0bbmr433329966b.24.1772742377772; Thu, 05 Mar 2026
 12:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Thu, 5 Mar 2026 12:26:06 -0800
X-Gm-Features: AaiRm510PSPJWBQS_37PCUJHyG63mM8SStGT47YeOYrA-ReNZi2iAZhZlUxbX7w
Message-ID: <CAKSQd8WpwYV0rxd7soKDqcv09Oxx1sUZPTHf+b_5hqgbxHcLLA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin C4600
To: TonyWWang-oc@zhaoxin.com
Cc: me@ziyao.cc, andrew.cooper3@citrix.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org, 
	David Wang <davidwang@zhaoxin.com>, lukelin@viacpu.com, brucechang@via-alliance.com, 
	"TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>, cooperyan@zhaoxin.com, benjaminpan@viatech.com, 
	TimGuo-oc@zhaoxin.com, QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com, 
	"CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1696721820B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223271-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ludloff@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[ludloff@gmail.com]
X-Rspamd-Action: no action

Tony,

can you confirm whether F=3D6 M=3D1F is affected or not?
(Supposedly that's ZX-D... but the F in the model does
make me wonder/ask.)

Presumably the 6FE and 10690 microcodes which are
out in the wild do not fix the bug, correct?

000006fe_00000000_20110809_8f396f73
000006fe_00000000_20110809_8f397072
000006fe_00000001_20160525_7214d1e1
000006fe_00000001_20170109_25646399
000006fe_00000001_20180726_6e07329b
000006fe_00000001_20180726_6e1e984b

00010690_00000000_20110809_259878a5
00010690_00000001_20160525_3c34fc1a
00010690_00000001_20170109_a8b24dc2
00010690_00000001_20180726_0c55f25d
00010690_00000001_20180726_41faefde

As for making the code conditional for Centaur/Zhaoxin,
stepping E seems to be when FSGSBASE arrived =E2=80=93 and
while there are CPUID dumps for 6FE that say VIA Eden
it is possible that they too have the bug.

As for making the code conditional for Zhaoxin models in
the string, that would require more than just C4600 =E2=80=93 the
collection of known dumps includes others.

--
C.

