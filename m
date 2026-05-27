Return-Path: <stable+bounces-254486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN6mHJx+FmqfmwcAu9opvQ
	(envelope-from <stable+bounces-254486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:18:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE9E5DF617
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BB783016D31
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244392BE621;
	Wed, 27 May 2026 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URESoi6s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3052285C8B
	for <stable@vger.kernel.org>; Wed, 27 May 2026 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859094; cv=none; b=P6YABfK036EuVwGGSWXhb5f5+zl8650HbebKkaSTpp6UhYJn+ikV+VFilLZ8Dvv4qEotYWj3qdVUESJRJPQM1WzJOs2BpdoL+RzFzSIqeH8SPoI9GnV91aRPmEv8JxEwavYjI3ngoF6Ke5VVyuadhdZBWshdm2y8ccfxsyvs4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859094; c=relaxed/simple;
	bh=a4AHPcspWRXRpwIp/1kvg29HkxGqT3z5y8I2grHxK5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iioMtwkbBJ8QwkR6hWmc3FVxG8Hn+Dr4WVi/+TwGovCcwb/ChECH41Cl0PmVjtl+0Rkmi6RsB8QmYaPhheEjVUkqvWADS4EmH40mVtzk2fRnydtkMJ7Y41siycIMfgcG4dQIQjlqT1rWrMTA/yCBy24bAPH/xmNjwpbvesf/nY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URESoi6s; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-837b39eb078so7833603b3a.2
        for <stable@vger.kernel.org>; Tue, 26 May 2026 22:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779859093; x=1780463893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4AHPcspWRXRpwIp/1kvg29HkxGqT3z5y8I2grHxK5E=;
        b=URESoi6svm1eDHgWYxDCmmKfDRG6UmsOWndVbRB/pva0Lls8QzZaj9F1KPSfeiiaDz
         pRz8RPwTEWuNE4UQZnDfAtvZ72Xh0xTcOo62qc26Q5GpVJFOakoLWYROWB+efeyDluQt
         aR6SpxEt8gqxZveLtsaWHSl7bjI12lwRJXUzvC6h0SI6O8f5mkEjt+63O681YgmaDXvT
         i8PxJIZ88BQ+O5yBZKW/qsI7EwnIXlQmMSlZkPP9HBaK1OD5y8MPWoAdsWarzVcx0qjX
         LWYDuUjhWCQnSZK0F1UHvGwIOlFj84E48QDKDw6p4ISzHJVUxvkQ3j6aqLwkTO08Ilri
         aUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779859093; x=1780463893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4AHPcspWRXRpwIp/1kvg29HkxGqT3z5y8I2grHxK5E=;
        b=p/GjPuWKIBPCNh1w1bxY5bsAvjzsMgvKuoTjajRcM1x8NjK8QyGBQlpccSRaVT+/Kt
         Mrws9k+WFfl+PRDO3pp8YB9feWZLbQYsXQNqIVAZvk6po5x76VNSv38WkwyOjyVSqeZl
         9TUXgOdRzAx3xAJ3d0Ex1BPY+OSIbBT6E7snKt7mjS4YEKcT+Mz5jYn5jYh3jtSvdsuF
         awY1fbKToBLt7FhmSgJAK6VPPlya87M9kE4q3AMp9OeC6mG63RplghbCbxJMsETSrJem
         ouXc4M0glskoTJokgUpmGdKbp0pB0obseq3kqHAgAintnaLe80Frdq8KdwOxDwX42FwI
         XUAg==
X-Forwarded-Encrypted: i=1; AFNElJ9Gqtm8w1I5Ya8DiIBZb2a70YiErMBV1GyDFv/VpeawwBSvaP/QvyakPu+gYeCtoYT2kpF8FGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZBYkQGTkI5Vl5MmugEH+obLpYF7jN3gqUSq/sfYj8+NuH6cd
	q5zvNZIAlurQGtAxvswHirkjTHRbA6UT3MqLrJg3Nc6UaebVINka9crK
X-Gm-Gg: Acq92OHLRSBaxg+vO9cRBkrpC6yNBceYQnboQyCwexzo5tvybh8JVAWO1Gx9TG6PNql
	ZZbykBmTX912p8abKx4WCZoNgxRbYzy06qO7f5Y+PUS3Gg3dAjIZOkljDtw/02KbA15HShL9RB2
	BHg664Cb0/pUAGzfnEM0qJlUc49Gxmujj5KgslVBc5It1srCzdqTanoJxmlykEqbYVdFekJ951H
	+puQsYoJlJuipTjmQrYMlMgRzmHHRPD3A7SKHjfIKCCz9n6gkXFstf7/78NrrMJdPCMR1Bouh/r
	zuMw+CfG2t21u8e/AXEklTyWvpzdGJ1m1ttWMSbU9S0GBK8YHOmILN/wDnJivwy3AQW+r/uBxMk
	oNPunmmJR2d58GR6UAFhaSjLG1Y2kkrlL07VHGqzHPRzy7NPldemotHhV3b1mzQctlp5MGxQblM
	75v6o7qHLOKtntPdsk/q3TmfSD907sOMSRNaC8V0HZBPMCCfrk5G2L6gwbdxZPDmXTkkVaVhJSU
	L4eUmvFJmNTzMmZnQqVG0Rmp5WKsNOuXM++kX5EjGcUTzIIE3nKIu7q69rt+srb+7Zap6Hp64SD
	GBMH7vwpidZMktw=
X-Received: by 2002:a05:6a00:2d25:b0:82f:5051:f024 with SMTP id d2e1a72fcca58-8415f5dcc6fmr19865612b3a.27.1779859092898;
        Tue, 26 May 2026 22:18:12 -0700 (PDT)
Received: from codespaces-78f0a7.2t4prynt4dlezbzls5ze3dxsqg.rx.internal.cloudapp.net ([4.240.18.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eb031fsm1146897b3a.16.2026.05.26.22.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:18:12 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: pmenzel@molgen.mpg.de
Cc: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Bluetooth: L2CAP: fix heap over-read in l2cap_get_conf_opt
Date: Wed, 27 May 2026 05:18:07 +0000
Message-ID: <20260527051808.47220-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <51761fe5-2244-457b-bf60-060e43f0cbd1@molgen.mpg.de>
References: <51761fe5-2244-457b-bf60-060e43f0cbd1@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254486-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1BE9E5DF617
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the review.

> By any chance, do you have a reproducer?

No standalone reproducer is available. The issue can be triggered by
a malformed L2CAP configuration request where opt->len exceeds the
remaining buffer, i.e. a crafted packet from a remote peer.

> I always wonder, if Linux should log a debug message or even warning.

Existing callers generally handle malformed configuration options by
silently aborting parsing, so I followed the same pattern. Adding a
BT_ERR() on -EINVAL could be reasonable; I can include that in a v2
if preferred.

Regards,
Muhammad Bilal

