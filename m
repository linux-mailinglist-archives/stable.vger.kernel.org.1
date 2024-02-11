Return-Path: <stable+bounces-19445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B514A850B92
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 21:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695361F21E4F
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD135D499;
	Sun, 11 Feb 2024 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c0oCFY08"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9535D8E4
	for <stable@vger.kernel.org>; Sun, 11 Feb 2024 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684837; cv=none; b=QD7NNmdp+AQdQ5OQLmwpB9CQhZbzmTtHFnMUXcQ71kFFXzM/5cTqg/mPRHCs/g33MprJfqSHrJOR4KqWO3PNbyZKxbA8mU7huV3nvO2bStXBHWKj03jZISeFB9Zhxzy754hUNP6xh161AdpGc/fFX50O8p8zgzNj5S9u0l9aSZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684837; c=relaxed/simple;
	bh=BMGzve0ANUBDH3vZhoeGqYbycgIDpj9y9bagw/WD7Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NPZDAoVAAe33+EZGd7GKwm2y5QAH/2sPQwN/2HozSikI5AtczvJmSkT9VBndS9d/nUg0J8Zi9/5cx/ueZ43fHD0DOWsdpMD7a/t0jZscivnDIoFPYvPavbYMOpFp1JSVWQep39esy7QtexttVZnTA1c+dzwctltFGUovj3YQE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c0oCFY08; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3beab443a63so2146674b6e.3
        for <stable@vger.kernel.org>; Sun, 11 Feb 2024 12:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707684834; x=1708289634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFtFZhEmAGL0jafx98ErrL9rjSRuZ8TZlZ5lyKSQNZI=;
        b=c0oCFY08iPudhUQpKz7vBEY9xB+l9VejOCOXnHn7e7XPwvCSeSIC12KRtvQ/Iwx5B3
         9VyBmaduamX2uTxdrlojESN+MMVQPsKYghrTylosAN/GaFQAuPt7rDx1nKS3jm5AXzOy
         9uelJ7Wao/n8BULprGkEZv3+T2q8Q5rqHE3so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707684834; x=1708289634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFtFZhEmAGL0jafx98ErrL9rjSRuZ8TZlZ5lyKSQNZI=;
        b=iB2DdTQfWVcKXndx/C13CKkaFaqj/Ca0l768EOGskePPcjC+xq//NMKfGqetk+5vdJ
         35HaoTSDjs++zVhk2EdSwq75zFIJ2aB1Q6EEUGilhg4ogRmCF9BTjgjzCEq87j++9Qnq
         JmGnOkoJUGOLIBe90tTaqXnX+P8J3lm6G8yMcvTKyfdm2np5K29ERby3ui0UKSfnW4Id
         KVwcgnBSzeVHnDsgIPB1wZ17//MizfewXXc6w1sSNqwoGazCivu9mpsFoWMGs67Vfzej
         +vwqfW5XSiKA9KCYMc7T6Yt05L9iF3joTkvGYEDElIVJGHTeah32606pNdtHh9qZWu2O
         KYeA==
X-Gm-Message-State: AOJu0YxIMip1Hgyt9gRzIIKfuzTAgYwrCUVtPDwGvoqD3XEM0zVFOSpP
	r6NbbFXWZEZAwn82wQwy0MjXjVHIR8feuTvsTyjGH0zGS23UDX0+AhOw2Lp6ywVlDodD1eWChs4
	r+ElNix8IQv5UAoczYquhg6q1kXRIXK7TlK+tyRBBmhkFOSJWhp3/2cA3iWOavGscdjqPLVDUu8
	Q4oZpxsJC7o7dB6AlDmUCToHq52Qf61hOtoMcB1/N3amRFDexe1Q8ARBI=
X-Google-Smtp-Source: AGHT+IE6q+ZfnP1ZtWGN678PUndV1ODyMs0Vii1BkfejRamabyPntw9fA2BBxL7yuUXfm4j9HbX5RA==
X-Received: by 2002:a05:6358:e486:b0:17a:e788:9dc6 with SMTP id by6-20020a056358e48600b0017ae7889dc6mr196350rwb.9.1707684833636;
        Sun, 11 Feb 2024 12:53:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJCKCWt7wYMvZT5DLlmemkwqBpsrAe+Ew2FsDcqny7rNQSZGe6CfUaeToZDLkrcLSy9U8OcdHeYDaahCj/DHYM5QJeJB/oJV9+FzYq7MEO0oOlNQ3VlunP9BHzaM8U8+PbKRsH
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id cv16-20020a17090afd1000b0028ce81d9f32sm5423735pjb.16.2024.02.11.12.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:53:53 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com
Subject: [PATCH v2 5.15.y 0/3] Backport Fixes to 5.15.y
Date: Mon, 12 Feb 2024 02:23:10 +0530
Message-Id: <20240211205313.3097033-1-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correction: The subject line in my previous message erroneously stated 
"5.10.y" in patch 2/3 and 3/3, instead of the correct "5.15.y." Sending 
again after correction. 

Here are the three backported patches aimed at addressing a potential
crash and an actual crash.

Patch 1 Fix potential OOB access in receive_encrypted_standard() if
server returned a large shdr->NextCommand in cifs.

Patch 2 fix validate offsets and lengths before dereferencing create
contexts in smb2_parse_contexts().

Patch 3 fix issue in patch 2.

The original patches were authored by Paulo Alcantara <pc@manguebit.com>.
Original Patches:
1. eec04ea11969 ("smb: client: fix OOB in receive_encrypted_standard()")
2. af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
3. 76025cc2285d ("smb: client: fix parsing of SMB3.1.1 POSIX create context")

Please review and consider applying these patches.

https://lore.kernel.org/all/2023121834-semisoft-snarl-49ad@gregkh/

fs/cifs/smb2ops.c   |  4 +++-
fs/cifs/smb2pdu.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
fs/cifs/smb2proto.h | 12 +++++++-----
3 files changed, 66 insertions(+), 43 deletions(-)


