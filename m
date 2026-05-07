Return-Path: <stable+bounces-244510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDuxFaYs/GkNMgAAu9opvQ
	(envelope-from <stable+bounces-244510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 08:09:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE8A4E3565
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 08:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 998C13029614
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 06:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0872332638;
	Thu,  7 May 2026 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6MeZSeZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A56306B3D
	for <stable@vger.kernel.org>; Thu,  7 May 2026 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778134097; cv=none; b=KC9jRepB7ZrlzPr5h7lAqqYlxmSqXmXSEWreuLLOF4TFQKM+Ee6P3bYZ/Vkj500dhVpvOqAj/Iu1wyIIwWuiOL0dTS7SygEZn+0MKXOkQrP+MB0ZTNyJO/B4pILFXtAjoj60t03TvYGDUL6UnG6iCI5CjdfH+v4Qpg1DPj6CaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778134097; c=relaxed/simple;
	bh=jUPabUW2yTu+VXzpJAujaISTd60waUB1ErNfTsydrWU=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=J8vBPdPjMfp3YTyRrrnir7Sufij5JdVAWnTDGv7yff1nIzWl+4KnUUW+OcH+4rInIIbTBqhb1mh7x0hl4xV2d55ozr6A+ZZ1sxZSdTY/efkLN7Fp/nBI7ORiAEQsPq9phUvCIYWn8uN9s/6hTBHOwu5uRoIWxkZ7RjPJC2OyKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6MeZSeZ; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12dca45ca21so772057c88.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 23:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778134095; x=1778738895; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:cc:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUPabUW2yTu+VXzpJAujaISTd60waUB1ErNfTsydrWU=;
        b=S6MeZSeZY98Yf4N1aREzvKHS25BF2m2fQ1t/XuyGSh5uGVH5WqZ+lwMZ7LwmTUWl6E
         SNQUgSNUNv3hIviqBfHhUXXvoUGYmFBNZ7I+XPUxaow5hEHuJ4sfuCp6RK7otS+rmcP0
         JjLTkr34pp9hOqp68anmk4+nBQ+L97eX3MvGgNnKc1+uBJL2QreBBnuiG5e6RfdrbqmM
         pKNUFJWouefcNQ6Jb8phrNMLyQ7ncaN4fZxRFRjujwLE7CyPis/m0PG3GVaMGIP1aqzL
         VWIFrQQuUpZoj3/J0jSupvNj+78VkiY3hUuzgEezuuG0qx1Z9zPQzCsjFyVnrrkOlqYj
         IR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778134095; x=1778738895;
        h=content-transfer-encoding:subject:from:to:cc:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUPabUW2yTu+VXzpJAujaISTd60waUB1ErNfTsydrWU=;
        b=UhUDCOidlVb7S414KYKi/kLoAqXeNlWpPk1+otn9xIUA1Zl5CHGg88CPevGKXt0/Yg
         jNPMX+Emd2S00vasXLD8TF10aco9N77xAIBeq0uSBSjGknUfS4EXBtihufuFP+oVlSq3
         pHPERBrQTQcWHk7lZUE9ruXqyALFt/lFAB6IhPAYgHQ+H9KLcT4+3ZFjZQDa9etcY8+g
         dK4DvAVNTysSxu43OCeg4Yz6Un2ny6SR/4uZKDZhV9DQK2TEU7qnXzQf1XxLTuBpdoms
         80CXydAcjKeq3PtNe7qN6AbYlxIOui0pCXmutxLIvrSX+yhIy7oGfz6CurQz6zBrt/0v
         NhmQ==
X-Gm-Message-State: AOJu0YwiclInuTTTVdQR/Zsfp1T4YP2uqY6wIk7rYG1TeWJcVIyue20q
	BwnExphL1sG3rP368TttTukFh+yF8ZXHTv+1nIW9mI5bwrfUjbb2Rj1it8EsaA==
X-Gm-Gg: AeBDievxREHoP7YtO4P8jFhnlwv90Tj+iSY2fArjCQ51NF80Jee9kHeCgMsJaG+WEyM
	iFsQEO9kdn+h1m9i6JxAqjjOE9IEzfskb3VfvRWG/e1N5WnCPjxF6wE3JOkOUeBFPd0BS9bp0SW
	0yKCjy7UlclFVZeJZWnWWitoYTdW1vlIuLY03Ff7oxmiwV6S1WXVbIRorYBaja8vws7vaRnq/gd
	QfFTulYjZ1QyN7L4WZiF6mUj5WWrrpEZ9Rrhb3LiwlLJ2FeqGE9mDuhFefFT/POBLrzwsNuLOm6
	2hQfk8cAul+6nMFYG+Tc5Q4bkidH3aYi/QebZDskxHsBaaKMuu2hG2rR9e+74xqbmVbsxxvlG+8
	u+ZdvBBmxYkXSqF48TBYA7SQK2pcfvsxgD0mkNwYXJYFUSzzSRQ2Pmm8qG5pa1QJI035rE5iQFG
	IiFwiSoX79acrLIkG6QdkC5btDlfI78/9DLXBA0/6qMCh2ElE=
X-Received: by 2002:a05:7022:6a1:b0:12d:de3f:f3da with SMTP id a92af1059eb24-1318ec58efemr2848251c88.36.1778134095357;
        Wed, 06 May 2026 23:08:15 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1320f16b189sm5001458c88.12.2026.05.06.23.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 23:08:15 -0700 (PDT)
Message-ID: <f0c6e3a5-2043-4611-9f6d-515aeb4922f6@gmail.com>
Date: Wed, 6 May 2026 23:07:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com
To: stable@vger.kernel.org
From: Yuan Tan <yuantan098@gmail.com>
Subject: [STABLE] Backport requests for net/crypto fixes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCE8A4E3565
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244510-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

[STABLE] Backport requests for net/crypto fixes

Hi Linux stable team,

Please consider backporting the following 3 upstream bug fixing commits to
the relevant stable trees. After my inspection, they have not been
backported.

I am grouping these requests together for convenience. If you would prefer
that I send one backport request per email, please let me know. 

MAINLINE_COMMIT                               MERGED_TO_MAINLINE_AT         TITLE
629ec78ef8608d955ce217880cdc3e1873af3a15    2026-04-02T09:57:06-07:00    mpls: add seqcount to protect the platform_label{,s} pair
426c355742f02cf743b347d9d7dbdc1bfbfa31ef    2026-04-09T08:39:25-07:00    net: af_key: zero aligned sockaddr tail in PF_KEY exports
01d798e9feb30212952d4e992801ba6bd6a82351    2026-04-15T15:22:26-07:00    crypto: jitterentropy - replace long-held spinlock with mutex

Please let me know if you need any further information.

Thanks,
Yuan


