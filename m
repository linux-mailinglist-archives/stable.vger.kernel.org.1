Return-Path: <stable+bounces-261976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JwT6Iz51JmoJWwIAu9opvQ
	(envelope-from <stable+bounces-261976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 09:54:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED803653B77
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 09:54:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dtRrNipJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261976-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261976-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 722A3303F7F8
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01E39659E;
	Mon,  8 Jun 2026 07:49:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5F1DE8BF
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 07:49:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904976; cv=none; b=A9i6Uu/62d7XstIRK5hQIH+rAd5EY8qaK0IUbGA9WFgRaglnpuTwLvVe5nXVT6FGRafafOK6tekfo/DSWiKIWO6VXCXGKerDjvT9+amGNVNUqar2L5AHaC4xydi+5OowZwhQ6cpJ6U3+PFfEODUkYYMurNixnAYNN5ajhgFsyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904976; c=relaxed/simple;
	bh=7FruI+Dvsw923Gy0MPP7mCp7wkqvpoIYW22W5HE/0rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKjbd+ALzAxMaDNsReHdLtH2MqXN2cPVePv2KF9jgqRB58c6mepq6/ewt8YckUEwuP6TcssTX74sEeeUTEeALTT9yCxZ+rgDMmTBEkHV7KQ6GrGo2tW6gsAradCuNYnbk2f+zQdglb74tehFzs407MRcLpK+DoVK0QJje5p77rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtRrNipJ; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf22d29dabso26140935ad.2
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 00:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780904975; x=1781509775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkcDIJRx6OSinr+5cJSRrWVMPrwGSeXex+O9jyO8udE=;
        b=dtRrNipJSFfNPmjRlp23btY8akVAejSFkcMKOnc4ZoWf8CgBncEhlbQzSdvFiNFl0F
         1LefpqbzuxetFiLyrg36OtwL2Bc4/MvWjQIXLz4E1OCanUAlG+CwAPMvWap+WQ7Jem/9
         rBXCH5BLg6DvflIMzp5fGRwFiAPP+H1ptZW8jhb85/nZIv4bu6hdjtgX5zj5XrNWvqGq
         Ifv8POe8j4lt0m8k7HIQP+/cPdMGO7VwbwfkQ7tNBjefswQezWhEO3KtiNuobqZP692b
         nn03hctOCkioWDUFbj/JZ83EbRkxRggTPokGoXZn+PNdhkn/a7mFwWMD2s1MPim238Bh
         eJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780904975; x=1781509775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EkcDIJRx6OSinr+5cJSRrWVMPrwGSeXex+O9jyO8udE=;
        b=Nm9/8GTeB9vyE+dHjyXdRaJ5d/OExM/NIdAyOWlur2w8sbEZk0ujUFqvZ01DnSz2r8
         yncRpB0tz5n2Uwa7n1D8nDXNVKEXb34GIVYa1CKr8QY/lM2f5MTqMUjAY32NNfNun622
         oFL6ZpMamJm1njecQaKpu9ZamR1Ci9zmkehDUAzbbEc5qI/kOf1acgak3lHq/NkJc29y
         RMQF8RzAEZhbAMvK/r4wMlvIAc/YOBnhCY1sFxgEWZsWDrDorGIcUS4++6NP6rSDw0gq
         3KDbzKDl1Oj1BSX5KxtOOyxAUidO4itqPZJfcA4/2JZJH/kHznHdgj9JeLNfc/Nan/qX
         E7gg==
X-Forwarded-Encrypted: i=1; AFNElJ92K8O3GuMHDD/8PBnf084OZw9hKkKS3wj2G4KiwCHt3pRa6KoFckHI8vO8IbVxQRgjgCBOq+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOg9KRVgY2HZbcGCU3srh9A/la3D1UKgvzkQX2BlOIoBqFFxM2
	DRTwSf/3svnx7bASlfHBJCg6k0B4Ul4b/++iPIfeGa0OxJLrJnzAyS5t
X-Gm-Gg: Acq92OHEB+4UtJcz2vNMY9+XSEPeb0jPBq6BhwqucMN3BEOI6x2DC5DWN+8De3Jer8U
	eLfR6gY5apsILD+VixKS4oMGtjn32oH/m7d81GhD5N69oVqQPBfbNVyATrLl2X30GbFOOLz+1M/
	skkZ9TGTQlpIrVd/KolIu4ThthgtlvW+/HThhKTu51KKeb6aWJNcoXYMxQ5HCybYvp8b0Hnotc4
	SSz4F5f+PSPXC6ETOzq9F/5PFG1SEkVBsK7NdNjDIcTd7a/m+iHZuN+7ZtvXRVAD5qZXib4L6s1
	kTLsFvlc7sldQaAIaJTn1YHbb7Wt+BrUUe2OTm8x0nAaNhFkMe264sAGeOwUBAkMokAXGZ5p3KK
	MrJQcZMu5vJHrRZzE9h1i7Qc5fDrxVXnNM4JqcxWbFQC89gbD57CCpjeNzwrNndjSYjhH5za/7f
	mZXWCi1i2YCrTs18BMw0U4fv/qBiHqnVAfP124bBAf8k6l4yYccbP6p9Osp3TZxfQE+VaLagwZK
	UWCrNlW64EHM6NHNTYxRcZJT5Y=
X-Received: by 2002:a17:903:3845:b0:2c0:a711:539 with SMTP id d9443c01a7336-2c1e7b3fe70mr172755345ad.5.1780904974861;
        Mon, 08 Jun 2026 00:49:34 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2d4sm160157485ad.77.2026.06.08.00.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 00:49:34 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: kl5kusb105: fix bulk-out buffer overflow
Date: Mon,  8 Jun 2026 16:49:30 +0900
Message-ID: <20260608074931.5911-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aiZiZy8a0al7xVXe@hovoldconsulting.com>
References: <aiZiZy8a0al7xVXe@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261976-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sammiee5311@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sammiee5311@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED803653B77

Hi Johan,

Thanks a lot!

Yes, I used an LLM to compare the custom prepare_write_buffer()
handlers in drivers/usb/serial/.  kl5kusb105 passes the full "size"
to the fifo copy, while the ones with a header or trailer, like
safe_serial, reserve that space first.

Thanks,
HyeongJun

