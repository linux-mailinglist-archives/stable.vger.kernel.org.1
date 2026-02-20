Return-Path: <stable+bounces-217589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EABoD92lmGl5KgMAu9opvQ
	(envelope-from <stable+bounces-217589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 19:20:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3F3169FD2
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 19:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6573040237
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA64029B78F;
	Fri, 20 Feb 2026 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+ARzZ1e"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4B13959D
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611609; cv=pass; b=sdNnak8zY0f2FYJIovyDHcyz1kjgl/ZsnAvQq12NYeO8VqY7cNAY2xPd6K6EPMefeoHJzsegqbqqqUB8N/z9Nkph8tJjXv00Cq3UQHQ3NejTyulEvym5fVQGssEQLFmhrGXt7hxpQ1lSJUjNDzfQE+U43kqKBR6uW09AFZ4Yjsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611609; c=relaxed/simple;
	bh=079/NS8VuSUOMcWzywWBSt20rOfVGMUvYmPiYDeKOB4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CaNFLC/XyGbnldkfNQ9mzszGUmXBLR37yvCMfBGuypsugebQK46fF2iLuW3JFP3uOuJPgFhr+Pz3CxI8W4JyTw5TmVf5xfHfPoTHWtn3584OxagWmg5Cl6T3CMZDdRPwov+T6BYRNVAmeQTi+VJN/TJ36bBlLOR5F1T8s+pOTS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+ARzZ1e; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506bad34f51so18394181cf.2
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 10:20:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771611607; cv=none;
        d=google.com; s=arc-20240605;
        b=QixC5T/O3O4w9jG85X4E0cYP7nnMuvi4gBt4xcvhhiFC4+d053usleeTAc9Ha2d5RY
         1UtPY5AkWOULoUr55oZ73LMfaKr3u9A5zYodhFH5uydvAJJwJCLXOvo9HO6SG4e14yEx
         HNohh98PQpjxyzOx9ASs+EAUY63u6LwQjZafjrwb/unW7AmsRpapOPrFnIPPyBKF+1mP
         NTO9E332NxEz2RPD2Tz4p8F4ssAGOX6iCT8EZRS78S3xRaFwHysK3h8hlDZ8MjVkrTcQ
         Bi560mgfOKYYLBN0mzMGf4m0oecl31K8Nb9dHaJvpLvai8qEHz8Ja0Gc8+A3HrTsn9Xr
         Lzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=079/NS8VuSUOMcWzywWBSt20rOfVGMUvYmPiYDeKOB4=;
        fh=mzrmzZltjJGoZQHgr2jk5Sdq55v0rsB8HP+UWEW4HVc=;
        b=D9ccbb7A2q7s9z/EsbB8aJvDuB5vtDw2RWe12bTnMKn1NWSnLXTMaNEKJjng7kMHQx
         5+GAmJoOwQfxTpDFMlL+U3M7uQCc+sfBPq5qm5TW/R0nvcYwEDuos+O5KisIV2kYxW8U
         DClQOZ+tqf0P9hGYbAXlkTSBD3H/zO2llbCOPi3UXfqQX5Ouvfl3CKrsHNooGvZSuKfF
         b6OSNGTQnPciy6aAWosrMjVndkTlWRaB2xcl0DwqOEkuHa6fKYbQXRd6KHqzaBOLc12C
         vX4AROcETmXg7u70fDqqTeTu/AiQUeySwruLKR2lgrdl1QaVUaX/DoBaRm3bQmX5+wu0
         G9lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771611607; x=1772216407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=079/NS8VuSUOMcWzywWBSt20rOfVGMUvYmPiYDeKOB4=;
        b=B+ARzZ1e0cfr3nizlrBXIHWQmrxSoEOAsKXcgbL2G4DM5nsRxoXPn1An9mae0K2YrH
         OkAWy3edeP3uf5oFw8X44q7St6KNhnU0iCtACDXYb6of8OeXXbxJk8yzfIw6yZGjqOKb
         S1E6XaUddP3vK2wQjrS9qZGTCfD8DsMTAY9hjzHy0R6Wivsr41zYfvbr1fl8fdd8tS79
         lYl5hxRN2sHYusgkISp3RWeEpqwVitBeCGoi9+a/pi/UEzNRVRrlft8xPFSEFQKR1mkC
         ww/hx+W39zCN+jAyx06S3Nx44ud5P0xQ7o80idmFy4brFG2rOANGGXyLnOEBSfbDlMez
         M7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771611607; x=1772216407;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=079/NS8VuSUOMcWzywWBSt20rOfVGMUvYmPiYDeKOB4=;
        b=cukBtJMBGfqYRY8qYkhF5ID8AKb9UgM644B5BkVl7mKlg6EBCo84anVURlWHR3inTY
         iyS49zNjY83sRRPTlvYcjIDBLZPHk/ahCY9W0tRfsJJPuoY09lwenLF05dK7cbzQ93uz
         990bCno5T5Os7BqcspoWaJ1BQ+0Y2CRfSLtwQeHRjrm75pnB0Fizh01npDlxOZS0wfvS
         gULAZhgkPbDDNoJVThFGazwQB0jNcLa+3GBMkwdUEAAl9mQ3PEo6Hpyujp+dmTQQJ8hn
         3v4KM6jPaiPGRzIYUxsrPudLavLVWXSqYIcCak0GTaiPWE84YCCwMM5srhuunlkdC3B3
         pPNA==
X-Gm-Message-State: AOJu0YxKPxrVCT2lZc58N194h7NWKHqi3HX/evK8/zsaWDT1XRHspED8
	WBy9D2oNiYSkkQzzQtRDMJBERTLaP/ehdFIdPEW200X1tbtCjoK9GS9yRFJZEkLft0Bz8kAuISI
	qZR/8Vuj9L6bGNJ9xGFShXdtiDsqNiIKKEB0pYMA=
X-Gm-Gg: AZuq6aI9pbw5pEUb6Fa9e6SVHJpqfjkfHBrt42k+C47E6cwtDJIwb8TmKXlXtuBJ4Fc
	F1ifqIDyWsMrCiwEOxuJ8tmngcE1wnu8vuJcVrBnvC/gobQMX4yv8w0cc1sncmfwXNUhnwH4pnW
	6Kh1fjsADrSswpORqvMz5nttByLxrnKmqMLbWBn/XfvdsyoBPoc34/gCCjyF3z22ObeQlPOFJq9
	dn9w2cyzryw6aTX/NmVs3969yByiJj0o1XUFAsHhaXzhf8kKxWpupblG2b4OMh4chpy9dXQ6WlF
	F+e04Q==
X-Received: by 2002:ac8:7d46:0:b0:506:1c5e:d1c2 with SMTP id
 d75a77b69052e-5070bbde721mr11233391cf.27.1771611606895; Fri, 20 Feb 2026
 10:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Feb 2026 10:19:56 -0800
X-Gm-Features: AaiRm53NcewFV0drPM_wHuaqtA-N7MZf7-M1X5pzDMz-zTmt8wwk1yBlW3nR6B4
Message-ID: <CAJnrk1YA9hk5Mv0BXFe+TcWLXsNLpWtcA-gy+k03zDt4f0z7zg@mail.gmail.com>
Subject: [PATCH] io_uring/rsrc: clean up buffer cloning arg validation (for
 6.18-stable tree)
To: stable@vger.kernel.org
Cc: clm@meta.com, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217589-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9D3F3169FD2
X-Rspamd-Action: no action

Commit id upstream: b8201b50e403815f941d1c6581a27fdbfe7d0fd4
("io_uring/rsrc: clean up buffer cloning arg validation")
Link to the patch:
https://lore.kernel.org/io-uring/20251204215116.2642044-1-joannelkoong@gmail.com/#t
Kernel version to apply it to: 6.18-stable tree

Hi stable@,

Chris Mason recently detected that this patch is a required dependency
for commit 5b804b8f1e0d ("io_uring/rsrc: fix lost entries after cloned
range") in the 6.18-stable tree [1]. Without this patch, the changes
in commit 5b804b8f1e0d use an incorrect value for nbufs when it
assigns "i = nbufs" [2].

Could you please apply this patch to the 6.18-stable tree as a
dependency fix needed for commit 5b804b8f1e0d?

Thanks,
Joanne

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.18.y&id=5b804b8f1e0d66413774d43f7a4b78bba0ca6272
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/io_uring/rsrc.c?h=linux-6.18.y#n1252.

