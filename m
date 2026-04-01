Return-Path: <stable+bounces-232711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNvKKFHQzGlFWwYAu9opvQ
	(envelope-from <stable+bounces-232711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 09:59:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9A3376667
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 09:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4736830C8E94
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FF639B969;
	Wed,  1 Apr 2026 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLY0cj84"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716CD38B7B3
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029703; cv=none; b=X7DJ5ipyAl2lYNzDjel+DIgLnEv1OQbGKbBP+dTHCEKh+lTGFYAU2yQ4OzO3jlUVWwUYqh/VmRYYg8wwrkYd7IQHzNNZyVVZ9i71jBBfdcFjwDv9hOXzU/l3+2XGmA/G2dzimTYJfHll2NyhxxBhKeXsS5pay978JtD1vv4aBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029703; c=relaxed/simple;
	bh=gCYniU9+niBnKTGH3VLO/XgApAfcaMyihtv2PaxvBAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kl1AenvFkMDvVUHaFeMrkpBXPRrvXFgAOo9AmcxgEDImthtzErHjCPHK5eak9HKk1vXs6nntSINzKG1Dt0fJCkTyARZIqlawgZsDvE6UplutLk3eAr2kGpeQFMR9IA3YVWe994wdjXZaPIjldKyHVBQEIRwVT0gicLf+Ltew67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLY0cj84; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so740507b3a.2
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775029702; x=1775634502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=352ocjL7rTrhK1rZf4ebKK7A7ZRbDOa1vgQVBw+5g3A=;
        b=kLY0cj84n0iRNKqXyh442pfV6ID3lB2VuY/JYfopttSXx11c8EhmFS8sro9XcJBCno
         pMItK38JvCMb+kaHiA6jdQQz1VIb313u89ayX8UQQ4S7rOUPsvrqx/SKlllaKwwJQQWx
         8sZgKPv67PLYxOFzZTkpagBOQK3xcyeTcpoL+Gbs9QE2xMCvH9JxiA8fO6fKChgzXoOG
         +m6YFt9WrjWlr2ijs0jFzpT9H9Be1tO0uN+ob0rjlhZfVf72r8tCOlcpwixRcwRkLAhE
         YCcT44VkgwJLNjj8JJ0QYAEUiM8ofiWjUDkCACoTB6Em7pgAj8cj+Nnrit9oUw3F/he4
         0XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775029702; x=1775634502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=352ocjL7rTrhK1rZf4ebKK7A7ZRbDOa1vgQVBw+5g3A=;
        b=ADotwLanHDbnXcGHK0E7UZBteAeY8IyOtYITA6nNe0sBReXPifL8/KzHVFJKbnJl2c
         XWnXAKnA7fgfjX9XdmseY5vQ9sHvIwYd5zGL1+M4DM0bvQuv0uryCPi7Wb5fmW4xjO4F
         Rnqib32jaLPpY1Xxa4f5oNGnIQ+Mr4dLrkDD8cI688ShW0eMBjIsX8SwnY+10mjYZU9B
         1JY1bZhlIAWvPsc+bcqQD6E+wz7fyxbt1xn7zMAMtpEq7n4rdL5HL0BY7lAq8Nm/QRmR
         UN5X9hRbpzuE4arGJvLNIHqJJNtefT8TIyYPyNMy2cY2ULQ+8sCoOhRWWj3qOIfBek/n
         NBkw==
X-Forwarded-Encrypted: i=1; AJvYcCW0OIgj4lyls9mBgJEn/uokCKCX/0sjX7TMYx9V0pN/kbpavqZusSNTTqnakPy8i91A1HLg0sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA98Q6gbcogywCohHraDGSJtIQQhmiWP3/AOW96E0vr8AYR+jn
	pFvJ617jPnw6ENd/Bs5dnKCp0eHts+Nfr0+E43oZ9ZB+6gwal62MJpLF
X-Gm-Gg: ATEYQzymrjhxQs68mOwFLSRphneIpK0ykN6MLL8i6N1DDexXeMwXrllqMR0VMDiCSkH
	OMX+DgkDjKXJYw7zCYkMQf3YwfWKfmq8RP4Px9XxZR4aqAqRv7J7rNQ2jAmYwLRj/ne7eOKtc0+
	vIxZ7xOYjxMCPBPOfWLMqWQBJ81uWKvqVAFzb1o8sapl1MjedCJUES60zpwjFbzR5U9702RCcEY
	dJPELDJjjTUyQ/jWWARc5luQ+/y5kJHvLGfp9Y5eBrMCv8voTULHpHA2nn/X1lcyh6/mUlRbUyh
	C7DHEWSus+XStV86a3gGTM+IrZryLhn3qw4RjACvqzZ732Xm+luqbB4Pvj4wrCLceRpZ6WcEA/P
	vG5lo6bC7oirbTxnyDZ+4VeM7hCdpTOAfH3mL7nT6q/UDZR9tjYkKW7AA5uSJDPFJr8Ce8ju64P
	TP5naCslT9mBNr/vfmNrxFWbaSImAEJKVeLM+SVIIuXREouBT1AZijjRwwIJZzjkMR6Voc1q8m3
	XxwbzzxNlYCJwWkGJEEnEk8TG4SuGE6Cjs5SEbeamoEAw2Eqlw=
X-Received: by 2002:aa7:8886:0:b0:82c:db50:ef77 with SMTP id d2e1a72fcca58-82ce8b1ae99mr2940476b3a.49.1775029701708;
        Wed, 01 Apr 2026 00:48:21 -0700 (PDT)
Received: from CN4GKQDX76.bytedance.net ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8465785sm16796789b3a.18.2026.04.01.00.48.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 00:48:20 -0700 (PDT)
From: Zile Xiong <xiongzile99@gmail.com>
To: tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	xiongzile99@gmail.com
Subject: Re: [PATCH v3] media: vb2: use ssize_t for vb2_read/vb2_write
Date: Wed,  1 Apr 2026 15:48:16 +0800
Message-ID: <20260401074816.31443-1-xiongzile99@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320113052.46989-1-xiongzile99@gmail.com>
References: <20260320113052.46989-1-xiongzile99@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-232711-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiongzile99@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C9A3376667
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

A quick follow-up on this patch.

It looks like there may be an issue in the CI/patch parsing path. 
The CI output seemed to pick up a malformed/combined version of the patch, which led to some unexpected checks around the trailers. 
Also, v3 itself does not appear to have triggered CI.

v3 was intended to address the previous feedback:
- add Cc: stable@vger.kernel.org
- fix the formatting issues reported by checkpatch script

Could you please take a look when convenient? If needed, I can resend v3.

Thanks,
Zile

