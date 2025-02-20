Return-Path: <stable+bounces-118455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431BA3DE7C
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259ED3BEDBF
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405621FCFF9;
	Thu, 20 Feb 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e2O79qjA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982071D5CFB
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065100; cv=none; b=Tx9NuPfY+KgFsWwjRrw9CE7VTHqj67AQm3zzqmoVVQnrBAgro0QsA+MMHYif2H/l8jYHNEVxgbKIVUPqtfj3sY3FUVH5YQ42T48/BRNKfXpZ/dWT6SdKEUQIL/Xv2Gfe5P+pmhuTxUf0Epi4wjlWafZgWOgXMfCF/a8xuZYO1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065100; c=relaxed/simple;
	bh=GHKtQKfRX625ruMmSBwhohcDd+91MZuTfcrrZYKfjbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjWNevqdmHHakIu9vDVoK97cQ34PxZ64F5+skb8NZrj2pttIpJQk/9AH4E1MKm6qAsS62Evf1Nt5T6u1vvxnpI927IGrpjMMZOE+Utu9Fft9I8RKQSoUAtcOom+ZqcseceikPKzDXRmXuimHC+qgF6XDZPvOyPB9YH8S0Lmohdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=e2O79qjA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb79af88afso210768666b.1
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740065095; x=1740669895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y956Nga+wi17KckdN9/Mw3XRjcXaF3kNwC0PxZ5/5C8=;
        b=e2O79qjAkEerP3tvld2a1wczWsVMeF/NWcmqhRFwwwKbRNl88p/wd/PtHCiZuguqls
         w9BSdfYZslQhBF18tWlQioqiCkrikva6wV/cFAWlNV4EwsaCYRs4Dy5jZauBTBp8stDR
         ZVOOGQGWoarGVLkPyihKtHmn72G7a2tDov3JfTRYuyoWTBjouB1J76pNufuF3eS2z1qK
         1B3rKxzq8Cj3GBadjzcPb5JwYuiKnNk0jgAe6InPgsGVXnOmOJdZSlcw+70V0bM1pKMV
         AehqUyrcMdEUTePUumdG/FoOFjfpy2Sa00BtfOVwjfTH76LsmlVKfreprfz3QaeVegoD
         SbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065095; x=1740669895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y956Nga+wi17KckdN9/Mw3XRjcXaF3kNwC0PxZ5/5C8=;
        b=TA0zNW7dhAayX7WYY2/jg1QihI/EWVPIVYTF/dRwvLyIgwBxqnneydPDFdLdDMDL+s
         F4fPlQjziIVMppSTj9tFNXPQ7cIfpowSoHGWMvY3PK0X9mzqYbDhNyGPXriWex34rLCl
         22TU//VNScR6maWaViZwRW0/LxRgEDWrsSHlZT+btKWjkOf55K+48/xNm58/a4wCyPu5
         LWYZFWfc0/IE+beETfHNUrD59FWFz1WRtamAofyfehgcabCduprljaTHnS2xxhdIvOPA
         G73XBLsPdkSIXZwYhXitzCkDAE2PAo2jcyL0hOU4jTYDvDfkwvRW0li7VNiEBYBAEvlZ
         x6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtA9iV0oqAHjH/nHN8/vOi3WwwDXYN1E7oLljKNA08u/P7gOh3B3N08TSYKQSFwKuGDeF2ssk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPlLC8iFAh14T8wqlPxO5TdHyQpybZ10Kpshh1M4jKyxJKu7q
	J20gct3Ny2x4+uhkpaBITBss++EGbr/cSXeikbmuHkSaBAOi9TZkOvQiFLpLPF4=
X-Gm-Gg: ASbGncsMfOSzr8NhwJdqkj2C+aCDkL9xyLXNW/AbGZ1JoG916EwetGDwrzJ5GaCRB6d
	ZjDDsJdoHmkUGN1PL+5ZeCVIix+wLWvRqUYhENyvULu2dj7k8Uh25tpHmArFxXqSCwE1n26ckpf
	H57P9dNepTjhbF1jg6WdP+9E8/yQGFHiE/rPw67Cf0qekzkDzrjjd93xmiSyxaFbxG5RKh+NZ4S
	sGf+lV2YcZePvharYtD0ZhxN7cp98Gw/XZ65SIjxgpSDiTQfw1C2eloC/cHUexwcmA+4axXf2wF
	b42uM4rMany1EPcLYAWh+peTxHF6FQpaYKVm9fTnezoyVD2KsN0NYtIjQaZjt/oSZcTkd8EP0ii
	jLuM+hbOgzvrgpzM=
X-Google-Smtp-Source: AGHT+IGpFy9Nqr+lyOCNzWNyFcfvqTsorGUY2iR8cFQABQ8lCUVSSIHVamd16JAap5iL/T/ZJ53L+w==
X-Received: by 2002:a17:906:d554:b0:ab7:ef38:1277 with SMTP id a640c23a62f3a-abbf3885ecamr256927166b.26.1740065094910;
        Thu, 20 Feb 2025 07:24:54 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f007700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f00:7700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9f3a695dsm751274266b.2.2025.02.20.07.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:24:54 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] fs/netfs/read_collect: add to next->prev_donated
Date: Thu, 20 Feb 2025 16:24:50 +0100
Message-ID: <20250220152450.1075727-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If multiple subrequests donate data to the same "next" request
(depending on the subrequest completion order), each of them would
overwrite the `prev_donated` field, causing data corruption and a
BUG() crash ("Can't donate prior to front").

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://lore.kernel.org/netfs/CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/read_collect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 8878b46589ff..cafadfe8e858 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -284,7 +284,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 				   netfs_trace_donate_to_deferred_next);
 	} else {
 		next = list_next_entry(subreq, rreq_link);
-		WRITE_ONCE(next->prev_donated, excess);
+		WRITE_ONCE(next->prev_donated, next->prev_donated + excess);
 		trace_netfs_donate(rreq, subreq, next, excess,
 				   netfs_trace_donate_to_next);
 	}
-- 
2.47.2


