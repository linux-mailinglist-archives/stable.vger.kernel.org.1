Return-Path: <stable+bounces-230901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A91D6UmyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 465C135229A
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C94C83004D12
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB65374722;
	Sun, 29 Mar 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8rlqykf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C537474A
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790299; cv=none; b=urvLUWXm9Gmiy1dLtXTocQFYEhA5GLrVBpppyD1jBPw28On6Zh/rx0GptZNFBfasnW9NTEQg9ANGns/Wn6RktIvHTbVGAcoj7exyw+R9r294Heiz47ZYikFk7VLok0hpcE7Wzx6CHyUnAowdaGRJV6k8B2wrvgl1zwXUN4gWBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790299; c=relaxed/simple;
	bh=TmyRJADySN25QyUcd5aRcPtlhK2ayoBuHlFEnk/DHY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6NlkFTvFFJlu3Iv1r+fnR4mxiwomhgg01Y5C6JrikHP0m9E/Ef7qzxLy+/55iUlC49oKmnnbgrGdb0EmUmEVy1nZrdjEDSTP0G/y8gxChJq2cEgAAU+FOGB3H+9gcVuPV2y0bVs28b3e1JyKEkEnVj6sgeu1zRWeuKhVBnKDOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8rlqykf; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso2215576241.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774790297; x=1775395097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmyRJADySN25QyUcd5aRcPtlhK2ayoBuHlFEnk/DHY8=;
        b=D8rlqykfxAPD6cbFiRfmrFfQZ8utjMmVV/fqFzv1WCqA4JOzN4Lzm+hmidOqB+l4aw
         wj5be/F5O+eructKS5vhoyFRIcoP1hYciG31v34BBZIhkcQsEYCKUz/7NEK80bCuVRoL
         nS+6NBVKI8xUliUP7SpZbGweAkwf6ixJU3Xh1YSWuSiITBa3EZTzWptGFE5IExmJNSVk
         IfSn2dkGGi9eomtcOzIcjFXWHhc3Qv9kYFrjLScw88UNT+SFl9Arq1nZJbBzCY+nmlX/
         RYjPY6gw+V3tALeh0f0KBGkmUNwlMsAVRiPN/TxDRKFULsUriPsc4/eDGVK5Jo3j9gRN
         +FpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774790297; x=1775395097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TmyRJADySN25QyUcd5aRcPtlhK2ayoBuHlFEnk/DHY8=;
        b=dV82aSyoj65Op1fOHn1+OIgVZkvrIVPw8AMcpmrlMWbTs5bAfvqsQG8zXip+Z7z7b9
         EwtF61wGFepIvQJ63vz0n5AwvH7ngzIRLZRYY3vG+Fy0X8Vaqc8N+fwuWahC7mTo+sXJ
         Lu8u4RULQCIsazSWfI/ZM1jhwfpqDDON0lP/LFduAVHbEiUBeJrnvT5AFbqaIEMy9hRW
         rrwKUN5F9m42ZJz4hcsRFwRJlupGFiz26Mz7U4HuT9VpVTTLbeXo0X8sl4noQZ985hcd
         BQu+97P9O1F7VgaukdvF6VqAdjUjNJjB0gly2HUQFeQENHbQW0bw1GZrwTE0j5XhNwTk
         7vMg==
X-Forwarded-Encrypted: i=1; AJvYcCVkuCtL24Oad8lBj3Yozy1bUnzfnN6Z26uMz8HS0Wjnn9Fei15RvfZAfz0v2pjmoj1KwuQ9gjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvjL/F3Pkr5vF/UDD0r+EuARRz24EK1FE2ewB4EMByo1nZTfdD
	5kGRunQb8YHQaM7VqC5/JdGw2rsoXHiqwrz6PdVFNe3/GeySR8j8jZO3
X-Gm-Gg: ATEYQzwc5NE+LUeVrXW2uXUEZBcfMC8NIfKR/2+uuweNv6tFipT/81CMjMhrRF2RGk+
	cH1hWoVcHHEsHzlQOdE28/+QdFaXn6fRRAYkw3Wg3C55BN5Vr9s906XYwmhcAJOgndztW2J8ali
	FB/mzdaPLFaXljt1iHtdnzhk1sCqrlFANUHwGJe4UNf1TPY+IqVzczMwtNv4XE8gTtipUm6IUSC
	mDIVMBRapDdv7aOzR2IVo0ssfwHgmQOJmacboI8JaZuf3ghBbWznjJwDfoIgdPZ2Rh4AtQHB8FD
	GqlKeHlYxG4LSvABnzW+QQs83Drbkm80yA85qexSQy+DRTTVV4l2TBZ7qlncMBSUopk9mhSf7bG
	EFx7X7tTxo1UA7/Nq74v5IR+yLUWYTnmeya7lC8HbaFdd8m6dnJlA0c7dxMOTwXmFNvY5NBg6ze
	nJonHPZbK/pv1MsA6nXKMlDhmB
X-Received: by 2002:a05:6102:d8f:b0:602:6c8b:4b8 with SMTP id ada2fe7eead31-604f9054641mr3473926137.5.1774790297508;
        Sun, 29 Mar 2026 06:18:17 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d72:aa::11:1a4])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-605129b95e2sm5422888137.2.2026.03.29.06.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 06:18:16 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: security@kernel.org
Cc: gregkh@linuxfoundation.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>
Subject: [SECURITY] usbip: iso_frame_desc OOB memmove via crafted offset/length
Date: Sun, 29 Mar 2026 07:17:36 -0600
Message-ID: <20260329131810.522006-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329125437.517980-1-sebasjosue84@gmail.com>
References: <20260329125437.517980-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230901-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 465C135229A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a second vulnerability in the USB/IP iso receive path,
independent from the number_of_packets issue in my previous patch.

After usbip_recv_iso() unpacks iso_frame_desc entries from the
network, the offset and actual_length fields are used by
usbip_pad_iso() in memmove without validating against
transfer_buffer_length.

A malicious server can send valid number_of_packets but with
crafted offset values exceeding the buffer, causing OOB memmove
that corrupts kernel heap memory. No authentication required.

The patch adds per-entry validation that offset + actual_length
falls within transfer_buffer_length.

Found through manual source code auditing.

Reported-by: Sebastián Alba Vives <sebasjosue84@gmail.com>


