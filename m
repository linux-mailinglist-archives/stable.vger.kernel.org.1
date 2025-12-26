Return-Path: <stable+bounces-203416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF97CDE5B1
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 06:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B6B33000EB1
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FC1DF970;
	Fri, 26 Dec 2025 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh5tGZoi"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D314AD20
	for <stable@vger.kernel.org>; Fri, 26 Dec 2025 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766728691; cv=none; b=HncPkg6sqotPsOASxL5sNQhRmaRve7F0cicDSbkTahCcgsg1HYUSVV8/QWEYM+QMuLjlhDv6URcnpGcI8M+ki7F2A1ztj+s1PLS4QHnk3+71Q7Ecjw/ZSBSggkDQyq1OzW6G5Q5WqJLVzWps5+M1y1Ys3HLtDoXiS4yXVzkoAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766728691; c=relaxed/simple;
	bh=emkMh02Q6ttc7Q/RZPhcfOPMT53pTT0Ad5hIy77TNBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8PLlELnfo8CXeTKQpkG14+8xCag54JDVgEtn1wy/5zG3HZ+CUmHsKipH5momf9hwy9JsX12BCEsB9BFRgWVx5Revn8+ih9pPDuhd8kj/Q36xavQNXOQqyvdbd88c3OUuf9BDCcO2wwfr50vP/lvEpHVNxt3mK/CUnk5fPuKZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh5tGZoi; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-459a516592eso761475b6e.1
        for <stable@vger.kernel.org>; Thu, 25 Dec 2025 21:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766728688; x=1767333488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bwiw7tmLfV8izGYWwiiJT1zXhrZjZ4Clv168Ox4HqPw=;
        b=Hh5tGZoiKuM3NJztDZS4pCMMtllz/H3gDT92bRBlHLkc51/zBJjjjuivKpq12FIVVg
         lW2jIpGuqtgM6yZ2UjvsDgwWvJwCQMQFrLygft5XKACBLsiKs6rfVChvxJfLjGTSc3Tu
         EdnBrPBMn5F1wsOvMSIrrX2gxZDHAp1gUtU5TId9ZIwJKQst6TTXn+iVaWpq7xrD/lGj
         bszbWkII+DlQvcLxHGKJi49jAB9HfF1uqmN6xxHEOz+9QBrppsBA5oqCXQcSWiWmIBof
         Qmgkvc1sbEOZrBaxOPuHeaoO4xXrT6T9+jKv5mU/V+o8dXE+YlNqOFu/ZqDtU/onk2yx
         D9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766728688; x=1767333488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwiw7tmLfV8izGYWwiiJT1zXhrZjZ4Clv168Ox4HqPw=;
        b=ispO9IUQjY3SkglY5SOXW5CenZ1C5x45Mc3Bd6PQ5qQS6IsRb1ZC6RyxmvLhAW3yhC
         KmbEvDwuUfibWcejejTkRf6VWW3fVHkgyw2mw/lNATT8AjfJEgUOXT7VbN7FRGx3ovqX
         ZgFoP8JJ+q3/scnO8x84Kr2p91tddBVNx+4fwdMfUvm1g6Pmt1UijbXEcGLjYIWvLk+5
         KgPMKx/tIb6TTGBhC/MKZeuDJfi/NdmNyABOkTWJAXesa7mSp9j5UaaMeZeDyRExqFde
         okqetMCcj4QEBOjexFdF0GFFtXsbkfsWOvgzKYewGfDX905xs3WDRczjByHlTWEwhE+o
         GPxg==
X-Gm-Message-State: AOJu0YxxpTrj5fREz7Kv04kLsQl4B4j0AklhPJ06dNsHCnJimiUWZHqm
	njMc4kttuUYYUKTPT7nDtr0qgpazGrFyyzYzSVyS6GF09t1w80CsA1rBeWKwNw==
X-Gm-Gg: AY/fxX5xpMLSFoWbHDJWj9uVmKv1bjrbq27OfgAaVnWCrMmHnULPP3xzw2soKJYP+Kw
	NMtSGi8F9iXNB0+k2hWkzpYBlM9nzCNDYYEQS+0MdCGJMecDwd0Rzu8aqlGMpEjjPIF4sl3qAvM
	DjUfFUJ4TGBVVgPwduq30WAexAcxxwKngte9mhr0edARGpyNd+byDdsfXK8J4j6UYCjISk0gryX
	Lzki/nFtNluijsiabsJHdvhJPBd+Km4+JifIxXHBzumNgo4JHBr/1KQcGFGlWJUaqwS4K2McxQT
	greXtN+rafKxS3ywqG2EyHkROEYZUXheVEMB/FaXMQbthO7pI6EBpip8mklzAAx+6W4OkxuVSIN
	8f6sYASSqR/6gmzSUO3zPS069a16KFCQifNXSMjER5nKI4ygf5LTzzFKXU+kbaaosZJmE8fkvCU
	as45YSV1uSdSR29Y8jMngt7WGfhTy+j1e6KqISUq61kqBQzpR8dQ1zk4VHyDI=
X-Google-Smtp-Source: AGHT+IEbYXMUaBY1WDYPye8ZFTP68iAFQKXwvIJGdrgeoPkqJ++gNaoMC3ARxRe+0RazTxyn93cW7w==
X-Received: by 2002:a05:6808:8851:20b0:459:b569:702f with SMTP id 5614622812f47-459b569766emr697392b6e.15.1766728688464;
        Thu, 25 Dec 2025 21:58:08 -0800 (PST)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66645494sm14532416a34.0.2025.12.25.21.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 21:58:08 -0800 (PST)
From: Adrian Yip <adrian.ytw@gmail.com>
To: stable@vger.kernel.org
Cc: Adrian Yip <adrian.ytw@gmail.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH 6.6.y 0/2] fix push_nsh() validation + silence selftest warnings
Date: Thu, 25 Dec 2025 23:56:03 -0600
Message-ID: <20251226055610.3120437-1-adrian.ytw@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi maintainers,

This is a v6.6 backport mainly for an upstream commit `5ace7ef87f05 net: 
openvswitch: fix middle attribute validation in push_nsh() action`.

I built the kernel then tested it with selftest. The selftest that ran
with a a bunch of SyntaxWarning.

Example:
  /ovs-dpctl.py:598: SyntaxWarning: invalid escape sequence '\d'
    actstr, ":", "(\d+)", int, False
  /ovs-dpctl.py:601: SyntaxWarning: invalid escape sequence '\d'
    actstr, "-", "(\d+)", int, False
  /ovs-dpctl.py:505: SyntaxWarning: invalid escape sequence '\d'
    elif parse_starts_block(actstr, "^(\d+)", False, True):

This error was then easily fixed with another minimal backport for the
file tools/testing/selftests/net/openvswitch/ovs-dpctl.py. Hence the
series.

Both patches was applied cleanly and was tested with selftest and passed
though the timeout had to be increased for drop_reason to pass.

Adrian Moreno (1):
  selftests: openvswitch: Fix escape chars in regexp.

Ilya Maximets (1):
  net: openvswitch: fix middle attribute validation in push_nsh() action

 net/openvswitch/flow_netlink.c                   | 13 ++++++++++---
 .../selftests/net/openvswitch/ovs-dpctl.py       | 16 ++++++++--------
 2 files changed, 18 insertions(+), 11 deletions(-)

-- 
2.52.0


