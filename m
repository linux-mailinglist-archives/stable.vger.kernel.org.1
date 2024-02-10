Return-Path: <stable+bounces-19411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4867850631
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 21:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6A31F22C41
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 20:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D25F852;
	Sat, 10 Feb 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NIHMCIfI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C85F565
	for <stable@vger.kernel.org>; Sat, 10 Feb 2024 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707595597; cv=none; b=RqwM6Y4C57YxGPAykQ4xoTx0fXcYWZnwipY/Di5lvuTGWY7+Eu+22sblmjP/48ppL2vbekeNbydAun+GZmpD8p6FXzL6CBXwRWvUUceQ6dDqYy6wR4IjeKZq2qw2ZqswTbS95aPqxNaZB8WoX3BR7K/QxDgkVzF3eOgkYShMMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707595597; c=relaxed/simple;
	bh=Vmpb07yt4oPCpc3atjVHNk2xR5ln845iPK3r+j+cks0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hyMBj6tz0hw6lu7+ShJqa5eBX8tT2TyweUO+L0sD2sj5SY0KQAjT+BIF2Y5WjH5KxzQPJ35rguW/v+j+EyDtIFuzDd/A1t+Vscessbc9c6EV8FXWeXo1SRe1ujr+dnkaOO0eJ9NrreRncz+qx3Cxt41AC0UmUEqBxe5LqS2sDDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NIHMCIfI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d746856d85so16604685ad.0
        for <stable@vger.kernel.org>; Sat, 10 Feb 2024 12:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707595594; x=1708200394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6v7mzz9B6+WO20oMc1FBVKh6TyupKe4My6q9d0HaN4=;
        b=NIHMCIfIRGuMJQDBvESGgjBIIaenWAml3+5R66IBlt2iiW2eOynXzy/RO9PyMXKKVh
         +z77HTK/POoC7ezsXdw2V2bBnrmrind4CrSS2LNJ8IbKTD83TQJXpoQ1MDa4oEfcssoK
         Pia20mvYfjkzEXWtjMBQnJd4qdS5WPGMrpheg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707595594; x=1708200394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6v7mzz9B6+WO20oMc1FBVKh6TyupKe4My6q9d0HaN4=;
        b=Sv9j/bSiFIOUzjKTBQV8kmc8rex/g5F7z53YsJInpExplI3Ihy/4znfH0ROKc/tcZl
         8gpEBwCA9Syzo32qj6QpI3qZvt/IZzY1V0geJd78W+0yzhPY3M1gmvKR7hKmJDXU/KwL
         TM76tP8CtUFW8dhsZeobkg6PwYRbDACYv1xgHs+u+nbEvJgnUPS/fYz1ZYlYmg1Nlvzk
         XA9OBUf5yUInnZOKuwGV7bIB7a3QCsWdLMcqTYr35RcQ8YcpXdbH219CmeTX6IDURQtq
         FCvFYTMyD3ICcr/h6wxNxYcvS4oV7Dh8vd0mrdL7X/f8YrHdgl+dVphs3q/YZpOmIXaG
         fOCQ==
X-Gm-Message-State: AOJu0YzAITXAGpkXBQrxOueW+EFBafXilP4pwB5cD/r7lcDLZWYHtZrV
	tMA4BROU6vLTYMdeiW29xWMR5faAQwi2nXwzO8l0fWdGrGR8TdKbORcYXACpG2JZko3BRCWjkH7
	VzyI+4BV8jcLodN/Kv5OEA/QXvU5x90QvihFc96nNFUk2g6MhH3qPvfEeZImTFa4xSPt0jGbVUa
	cw48O4hJJy26VsIIOdUnGJ6EJTaJKzayF3y3pXXUbJWIHL+jMFKMTbvk0=
X-Google-Smtp-Source: AGHT+IG9gBFvr7ZCiz9pwcuBPvGLjLf6TWLMfRRLLXRZoBVGjORVaeo3ugppFc3g0tMbBVVMRA5G3A==
X-Received: by 2002:a17:902:6805:b0:1da:1d7f:1bf2 with SMTP id h5-20020a170902680500b001da1d7f1bf2mr2328279plk.48.1707595593935;
        Sat, 10 Feb 2024 12:06:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGC01euG9XSKyYn0K5BrodphLiwx1mth59iqB12HQW8N0yp7hXwxI+oONe1Mp8y+VWs+L80TAV2JDRZPzDY8DOEX2RdVSnbCy3/O4SUV6fBQXJGsFNAPZaHSEaGiV5AM5mbetV
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d9af77893esm3373392plb.58.2024.02.10.12.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:06:33 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com
Subject: [PATCH 6.1.y 0/2] Backport Fixes to linux-6.1.y
Date: Sun, 11 Feb 2024 01:36:07 +0530
Message-Id: <20240210200607.3089190-3-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240210200607.3089190-1-guruswamy.basavaiah@broadcom.com>
References: <20240210200607.3089190-1-guruswamy.basavaiah@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are the two backported patches aimed at addressing a crash.

Patch 1 fix validate offsets and lengths before dereferencing create
contexts in smb2_parse_contexts().

Patch 2 fix issue in patch 1.

The original patches were authored by Paulo Alcantara <pc@manguebit.com>.
Original Patches:
1. af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
2. 76025cc2285d ("smb: client: fix parsing of SMB3.1.1 POSIX create context")

Please review and consider applying these patches.

fs/smb/client/cached_dir.c |  8 +++++---
fs/smb/client/smb2pdu.c    | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
fs/smb/client/smb2proto.h  | 12 +++++++-----
3 files changed, 68 insertions(+), 45 deletions(-)

