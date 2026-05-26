Return-Path: <stable+bounces-254365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONJyBZimFWqJXAcAu9opvQ
	(envelope-from <stable+bounces-254365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:56:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEB35D6F06
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4E3E30485E7
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A5A3F8ED8;
	Tue, 26 May 2026 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqG9xbwi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC53DDDA1
	for <stable@vger.kernel.org>; Tue, 26 May 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803415; cv=none; b=aLFPoQ1kOtnK1mi39kXGCNiz2MPYWAWbmww3nKw1QyF5NB1SKx7mDNlYTs7PFW8EO4z2YtmphJYhmbF5rGDAi3K+O2J+QVCRbZZgAhXGslbrSPNdUZpXOKmK9ouwhp1Qc2X6eVkk763JO2jOlGOeDqfrcIzMCzVSNQy4UqEJ/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803415; c=relaxed/simple;
	bh=Z+AqW9VjxyfF7vVwwOt3ym9tEOdvlxHgX0JSmUMfkh8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y/hwijTn0eiQ5zDwderbxF0hFSXyRvkAAEtWumHPdRdGnj/B0Mi8Z6GVrpuRsn07xUIXDczc4RiVNWE//B0xbA6Oh7xRVu38v2RxzC9qrExBsfDTs9PIMJlSHSS9PZXEZ2qNOcmCEXfnDUjmetRAPM39gDyGdYWPDg8AThF3LLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqG9xbwi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49050bfe053so8410335e9.3
        for <stable@vger.kernel.org>; Tue, 26 May 2026 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779803413; x=1780408213; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kIPLGO6v5O2FFZc0rQHtJRhaRQ7RYpji1fNItyhs0k=;
        b=NqG9xbwiqlvQeCku1Yld/uiZJooPVIK11wuQpj5znAijAQcWPhYda5tIxnvFkv5jX0
         Mu46CMWnYAdyEN91/gBuxB6g6rFRQyt+DadUdJcwgzsOdUdRfX2T870xWyVQLj0f1HNI
         eCYajetJBMSiJn5Zz4d1MBFtNt3cGkE0m3hZUiqYaEup9JLuaTRN7UakKjH6h/OTYwp8
         tMcd8+2sOVGuhuHuXj1CRYull62579fvTkNgh2aKTQ+7UcrD+QOcsHRvZrdHpbTd/An7
         wGY81q6EV6sBZzirI37NoZaGbBDYSEX+FcjpYP75S7SLoFwFvlaG/1pXCV+ZegXpnXAg
         qlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803413; x=1780408213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kIPLGO6v5O2FFZc0rQHtJRhaRQ7RYpji1fNItyhs0k=;
        b=kKKcFiY14Hbg7iJHmto6Uj+UFmHTbHiBYnsOubGb5v5ifLI8tIDCVWPid5qFecUpb1
         mw/aMCvDlJfyWMZ2SdTXeQpdykQjt81VzCJgyArMwmpBqBK5PbhLaI8ODQ9AsCnHQM6t
         9XQ9PRLJhIYKECFuOTA8A1QVxmxHOVZ+6jvmyu7Lp9kvDkZQTVaF1zeq8b4LZXL43EGi
         gokdFK27207AGMAHfN4w8qt7EOH1rW/ukeGzCfS+gGMVE/nph86yRVB1d+JJM+wcxN5Z
         ga+ZyihQWJvXCy6wQJzcS/7GqMvMRWqnWiENLejjjn66hVcW9DTJYgItVrimbLqNTQog
         Z8YQ==
X-Gm-Message-State: AOJu0Yx4Y4yRc3pj1pP9vU7qTpKGvhJ0qc7Fc6cig8rF8zOLDvJ3CA+w
	oFETOW+DfXNtGx/XqG3s3n3rT5ezQKjRugp8dmNm86gmT+AQaeu82C86KynjsA==
X-Gm-Gg: Acq92OEq+p+DQ2VCPQtL0RO1+TLVx0T3X5Akiq2daaKEA3AaZb4+E0TcRyC5dtFIUgu
	olLt49l5pOCuTcEL+BkWE/jgXM70+Poikg/6bKqzG7KlInPgQorhyxuRQZkhNCc3BnE6jfn1Tjd
	bfMyTZPdD7qfeLvIcWlBfdn0W3xLeF8nt3NK6Uz0XPBVH1t8v3i2FTZrAnvkEfXa9lptqBJs1eU
	y0Tzomm3yq6PcHFiESyoJrMh1NP/Ky+b9cxCtAmeURwJ704plo2ePGLSQDJIuHQH/+1EQZvijHf
	A7lkIR2Vmlqxt8O7yvKJ6+Jn3ruPi4ka2142/P01cW9koIqocsGjXYQOFJEuiGonhAeMFJjKspK
	NsV7eDVaGrmj/68GXkI0Nc83tChPYooVhmf0rbTiGe+nMKQaaMe9QgILvswxWEU073V4u3hMffs
	gppPvhU/cak/dQt5n3XRzeXe1PM+IJNksebw/imCf9gO4/QvWFODdokukrperLwR3xyw1glVTaZ
	VoTpeCwjNCZxMiDbYYvO/0AQGmmn7LqB2ZqbyyMYJPCEgOvn4B/2ikSZlfhXrDWW8KAkTBFbZY=
X-Received: by 2002:a05:600c:821a:b0:490:5cd8:d21c with SMTP id 5b1f17b1804b1-4905cd8d437mr206602895e9.14.1779803412535;
        Tue, 26 May 2026 06:50:12 -0700 (PDT)
Received: from franzs-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452765f5sm339056905e9.5.2026.05.26.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:50:12 -0700 (PDT)
Date: Tue, 26 May 2026 15:50:08 +0200
From: Franz Schnyder <fra.schnyder@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chuck Lever <chuck.lever@oracle.com>
Subject: [stable 6.1.y] Will commit 7e96a281fa07 ("perf tools: Fix module
 symbol resolution for non-zero .text sh_addr") be included?
Message-ID: <ljz4f536p2oyxrtc2tklh7ymdqg2stcijj2cjepaaheqlw5ddq@vgqf24zcaadv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254365-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fraschnyder@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7FEB35D6F06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Our OE-Kirkstone builds of linux-6.1.y from linux-stable-rc are failing.
The problem is that the following commit is queued up:
7e96a281fa07 ("perf tools: Fix module symbol resolution for non-zero .text sh_addr")

It calls `dso__rel`, which is not present in 6.1.y.

util/symbol-elf.c:1010:21: warning: implicit declaration of function 'dso__rel'; did you mean 'dso__get'? [-Wimplicit-function-declaration]
 1010 |                 if (dso__rel(dso))
      |                     ^~~~~~~~
      |                     dso__get


I wanted to ask if the commit will be dropped in the future stable
release, or if the patch that introduces `dso__rel` will be included first.

Kind regards,

Franz

