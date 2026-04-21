Return-Path: <stable+bounces-240017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CvvUIyXO5mlR1AEAu9opvQ
	(envelope-from <stable+bounces-240017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 03:08:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EEC435389
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B30E630058CC
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 01:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94120231827;
	Tue, 21 Apr 2026 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up26EzHZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8A17B425
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733726; cv=none; b=QRaDKpM9AkjfCm5ttbZIujGi/v2AU+NFQC3Wq7+DHo6ppmdEZNQvMZjF6oW8x2QWRYe4DnUlUoRWUa3GVZecHSxydNrrnZQUDKSBEMhUZk23cASN8HSOhYHpWRXPFlnn89fa19rVXjrX0NaCqhrTqiVO57mfnpV9jKPN3dkwQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733726; c=relaxed/simple;
	bh=7H9M3x3bqs69kmxhQDHyqH7H3xQvadbsg0DHK6NrJqE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nPIaFD14khZNGoGOdD9UtMYTu4nU0IByTvD48HTJV/LYhZ/cEAMXBN+BEdCu+90tmLTwUbyumG5Z5NV54fFK+SOMCzESvGoX9qimQpefpOug8b96LfhP5f2dylfOGx7IibPST1XT8r3TRppZn/WbTKoQaSdDJ+jlCD7fLTmK5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up26EzHZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a9296b3926so21079515ad.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 18:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776733724; x=1777338524; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7H9M3x3bqs69kmxhQDHyqH7H3xQvadbsg0DHK6NrJqE=;
        b=Up26EzHZ4+jn3nyVDrvYYa2sgCNvVlv67mMqKCS+2WbXNa/dSxesvYcA/3waUw3zuu
         W/S97p/afYzZ6+2VcKyXEbTAbNL+xse5mFesEAUpO06V0OFXqNgz6yI3+j3heTwHB7m/
         rdi8X/L35+l00R3Rqidlp9HSmmftUdNMbG5UtqNg+HTl7ZEY1ce/5MBroJvPrRGuACbW
         VKua/LaTLXl/sYL5hwoilu5g8wgpFA3rRRfgq4+r2P4M2M/FXyqRmapA7zS+f5X2n9+7
         dMA930idPl3sTU1iuTad+91n0PjEzkllRX/PE0aslnjaEE5Bo8etAUuOodFhj0BUH7WK
         aPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776733724; x=1777338524;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7H9M3x3bqs69kmxhQDHyqH7H3xQvadbsg0DHK6NrJqE=;
        b=m46dx/i+6KxQSc+VjtsrDj+C/uUgJP1q4Be+zSdy1AXW7puUx0rN7uwr90N3pkXTwF
         mf1a+NHccVFd7U2s4dmV7bVYwOyUSUiP/O/huSQBk7EyVhUe5eGY+3t+cNbdFBMcxakm
         EUlkmQwFvJAvCFWLb8IkRvhw6lAg4XyhnUGAo3uQfcdRVda4EIGY0GJoF01exW78HUPp
         mJVw4kONrY6XvCSHB0fyNphzUYW2XPZrHLG1OzdTASiD6ql9X+nScnltYMLSdtuOmsQW
         4+Yyt8z/zwRQo8EY4mv2oI5ucVU3qKoJz3bwlS3Nltn31e+vY8oPK7esfUkWlpmRKTzA
         /7/w==
X-Gm-Message-State: AOJu0YzFT5cDszItJ+QnxBtC7LtA8kRLiTAvKjMkPH1elWvPFFECUFcb
	89oCG/xLGlleXZbMYfi49lKUfpqNv5l7A+WIup/Z7naa1GPqXlKsh5B1EzbXPA==
X-Gm-Gg: AeBDietP2QcwFylPZTDQA2YaHGEqah1vhAXozstTBOUGzQIEDdRWNtJt7eFbyNuVXVn
	5TLYdf7g5lmPEvQ+b6OI5a2y/pre/+mEQp/f+0QIMNFucOOfSGj/PSYO2U5hcvSOQTbic0L+AR4
	yoQguDadrynKD0F3Uxb2N0avtrV5uJzw801IsGaZDkmzHqDhpJt1S0keDvLxwmrRZ/R6TjOUqAI
	9j/fpk9VDDQbhAPNe0yKy0JIwBorRjnlcnRLcENaUHOUx9eDvNUkE4XZxmk4kLbgsHbPZFCKJN6
	TfKPukw126aKdGaeA3p9o9/KuIoWmeP1uDMmN9C3IHAlQB5rXL0YD/zEre0/nbyZ/J2JoYeIek7
	++smL3JYWMjc8pOEGJm5zfgVq8WQiGxQANZpLyzCrDS42knO/JBqBmfhC8US5Sh0wgV08E2xAEK
	TZ6mJIgZoG6e/rxF5fqIOzSGyS3Q/OdPit
X-Received: by 2002:a17:902:f78d:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2b5f9d888e8mr155879795ad.0.1776733723724;
        Mon, 20 Apr 2026 18:08:43 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm114740025ad.78.2026.04.20.18.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 18:08:42 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Haren Myneni <haren@linux.ibm.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Guangshuo Li <lgs201920130244@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/pseries/papr-hvpipe: fix NULL dereference in handle creation
In-Reply-To: <20260420132429.128075-1-lgs201920130244@gmail.com>
Date: Tue, 21 Apr 2026 06:34:37 +0530
Message-ID: <fr4pt97e.ritesh.list@gmail.com>
References: <20260420132429.128075-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240017-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,lists.ozlabs.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 27EEC435389
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guangshuo Li <lgs201920130244@gmail.com> writes:

> papr_hvpipe_dev_create_handle() transfers ownership of src_info with
> retain_and_null_ptr(src_info) after anon_inode_getfile() succeeds.
> However, retain_and_null_ptr() clears src_info immediately, and the
> function then still dereferences src_info in the subsequent list_add().
>
> Store the transferred pointer in a separate variable and use that for
> the list insertion.
>
> Manually identified during code review.

Thanks. Although the fix for this and bunch of other fixes & cleanups
were already queued up for review in here [1].

[1]: https://lore.kernel.org/all/cover.1775648406.git.ritesh.list@gmail.com/

-ritesh

