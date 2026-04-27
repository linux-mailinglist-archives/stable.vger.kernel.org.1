Return-Path: <stable+bounces-241281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OPeNlMs72mb8wAAu9opvQ
	(envelope-from <stable+bounces-241281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:28:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 576C046FEB4
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DB613007AE5
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAAE3B27DA;
	Mon, 27 Apr 2026 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXfx+mps"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140CD39A04F
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282123; cv=none; b=RJesUAiQhYAP8b/w3Z/ZKeO+KkYMvUgahyz436//sJ8WTyJhOiySzDcoUKDRj+TA8jBNofVlCCCeun7dGCnw1Um1JvCUzxlcKIl+lPJfP3nNkgEud2o2U5C5YjtaNviIGHzWZnUwYO7FePCnUlyLUxnmsz1A3zlh5Z6Gebs2yTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282123; c=relaxed/simple;
	bh=cWlCOFhZcpalfl3WjAaLRxx9ew6UD/guyBxJt7n25L4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=mGMPCOfhxPvUJcsE+hjQRUJmfheCau89+Mi4aOIDAFoR2wE3IRHY7khFU7YPjrKUtcsQS8KRJ7ZGHsOaTofQE2o4bsRE4N1jGr+/t0eFGFJiPeFOsbm5/hHeL4252ULmjHs77AxTbxveAliEhgjPem5pa//Cz+veJj82RqMSJtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXfx+mps; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so6482302f8f.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777282120; x=1777886920; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nnc/PUQBSU6rmjuW9Girol1kceDL3q32jW2r6UBTf7U=;
        b=pXfx+mps0JUafPEN6dOk1kffuiHx6fqZNFhXPndfFuWl6ztSEd9lGuDA3vpheBEfRy
         6fuoj0/zxzfyfDJRNr9m8fc46IYglp78hkbKYuT1SKNh6ZdLgUXUqBGSvCJzfi3f9X79
         4RQzo5P3bA917hNyzTZ34wqY3EK6WcFvKpv7ySNhtL0UHnu7MtOAApJCoaQiohJo4Lc6
         uQWB/AY5BucF8uhpDuCueMJaayDLwNAfOrfKXhKQJjsLG0qui3WnGT3Vg56TNZPuEj4Q
         QBBFhjYXqVLpty5QUYR26buKHEu6+VRwEdO0Rp+UOnjPdPHmePAdwVvQBQNT7Q7LChxJ
         ZgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282120; x=1777886920;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nnc/PUQBSU6rmjuW9Girol1kceDL3q32jW2r6UBTf7U=;
        b=haVl1X8FvR2R02WihT86q2W3x9GGdY33nLlNpNEtv//11jXtE6M9zRGOHKajpzg/iA
         bHjM1s8WYzVxDKdcKZ7igMHf2tGpgWFSFHDcaY+dGR8YSByETgW8ge1wqIh6zOMNj3fo
         QrPT0zc//P1VxahYdJH8Y2NfykCEc6u7PUG9/ZZXmaHS3UH4ATW2JuToEmQefdOiwvGG
         fm+RzAGZx62X2CQC8dxrYMJwXxKIvr+/Hcw1EVRRe5c/8Cea0QcopcbZTX/kTYncvHEd
         Om3DpuxEr1L/P8Gtp9n9pRRnNsmuAXFxRMxOolB64UE7DIps2INFToREPvpA8v5F7VCj
         u3Rw==
X-Forwarded-Encrypted: i=1; AFNElJ/I9A4zxeIxjR3GWRE9yNFknTIeYMepm1pn7Ls3+Exb+nJDFDPYZKnxGl8dIQEtq+t2a2Ga+C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkpB68eNOhISLySMFqggczXUDMantc9Oq3PmVajFqul9DVpKY
	ZFzgDRmLrIX3WIhS/RGATBL32tkdr6oz5WeFOFNxnyouvye6wor7Lt4TUNvYEAxp
X-Gm-Gg: AeBDiev5KnsYCZx1/1c44R8Jt5/PfrVPRGOT7FRf+eVxFxMBRuX0wzk+jmpgGRTW3fE
	ltGq8zwNY2yfMIBfo6ye/PpQTeTDtPtCLOBwYleiCWA//1tQlIHp2BtRHiGVCKgq5bYsOJTl+YF
	qxwFZ1qrQZBT2FtTmJJuEl6uHQbD5eOZ+Ugm88FeH6HSOqQr2P+XjsVJZjCY1bB9wB9E7Qt8+xW
	ghgEJ3+7DAd3MuK/Fiaa6z3d0hahk8cdpSOzHQ4FyYshCgcI2W5qb12N+g2aGMppVd7pbro1j4W
	c/ckws3U90ZPpaowh8FNP5jBVs3OvUZLppWc3hPq0Ns70x9GwXjSt4AhcM/NQqb3aJfm+ZnzebE
	6Irm1/PQatZFrEv0+IixelFX/bYxKuTIXAN31Y75HTJzJGO8djtexDkoS7nKV/qIbvwGVh4CoW5
	FMvfQQyphCSDJ41LAATjBkgUKquycBsKcbRwj9xNJIzGUMs9hN3qUxV0CfxfezEX5LwbeR5uwcK
	mmN9GTnbj3Y1gXQgL3bVrkGxbGFwX9DEYApfb2pFKfcMwQjjVR+yG/fYqixfI5sQialMlI=
X-Received: by 2002:a05:6000:2508:b0:43d:71f4:7ecf with SMTP id ffacd0b85a97d-43fe3e1131cmr63955799f8f.38.1777282120103;
        Mon, 27 Apr 2026 02:28:40 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a071sm42776641f8f.21.2026.04.27.02.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:28:39 -0700 (PDT)
Message-ID: <69ef2c47.5d0a0220.2e33d8.bde8@mx.google.com>
Date: Mon, 27 Apr 2026 02:28:39 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: Dan Carpenter <error27@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, luka.gejak@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8723bs: fix OOB write in HT_caps_handler()
In-Reply-To: <ae8pq5YzEe2wTJmx@stanley.mountain>
References: <20260427081748.3407939-1-hossu.alexandru@gmail.com> <20260427081748.3407939-2-hossu.alexandru@gmail.com> <ae8pq5YzEe2wTJmx@stanley.mountain>
X-Rspamd-Queue-Id: 576C046FEB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241281-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mx.google.com:mid]

On Mon, Apr 27, 2026 at 11:17 AM, Dan Carpenter wrote:
> We need a little change log here.  I was hoping you would provide
> a link to the AI review in the changelog.

Hi Dan,

Sorry about the missing changelog, will add it in v3.

For the AI review link, I don't have a direct link to the bot output. What I know is from Greg's reply in the v1 thread on lore.kernel.org, where he said both his fix and mine would break things on some systems according to the review bot and asked me to use truncation instead. I went with min_t() specifically because he asked for it.

You're right that technically early return would have been strictly better than the original, the original was already writing out of bounds so it wasn't working to begin with. But since Greg asked for truncation I kept it that way.

Thank you.

Alexandru

