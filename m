Return-Path: <stable+bounces-227839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IORWLJT9v2lZCgQAu9opvQ
	(envelope-from <stable+bounces-227839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:32:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D10C2E9AE4
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE28E30214F8
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BAF363C45;
	Sun, 22 Mar 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q0Hl8Vt2"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46DB35950
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189843; cv=none; b=byThedTtz7vCcZf0Ny7LiwYVHUhyVBjfTnXXVRpjQE80UTZ9GUE3zToHL5tKM4MioWW4Ye+xYmwxn/JxVklMQaLhOiUe8cxptfu3oAssKhNFYJex3R+MjN9LuZCvS93BiVP3VxIDEBLt1sBQHLqp94cCReDjGwDgdsT/Pg+jZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189843; c=relaxed/simple;
	bh=V+YRdvkTSoa/d+GYqQRAYGQCkJMJpcL8Htec9eIAdgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=afxEUe15qVg3NbItNlivWm66ZrF/uiG9C/qrjpzc/UjP1f1x8iCDHS12WzDoKG95QPQgp4uUjQZ8eeeFsrj9JBpJV/L5Qp8/jZyWkFo7URiQ9b5NT//EQeJLk5FfflEhH6iUjMd5lxU3l7tUyka81kRNRdyGPPHAjLasnWPbGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q0Hl8Vt2; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4670464029eso1379655b6e.2
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774189841; x=1774794641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHK1YAHhATX+BOrgvNcOMGXM1iLk+EcLOH7Ra7adyWU=;
        b=q0Hl8Vt2E/hKdFWOG7lJfkpSPyMe40OS9nVR99NMW0WPhu1wXp59/kL/vMe9Dm7E1D
         ihM4MhftzEtJXRYwvF0JHF+reFf2ql4ayZGTYVbe5gwXDRHigKK23lhHLn3x/Xj1Eqjd
         Zf0aRu30Ls8lZHY1kEFAJlfA2pJUfsXwqfNqYXse/bzGjEWFN69juAyldy97thzN1jeP
         q2QyGI4EG1BuD63gJCV61xlvHlmhKJFsgOQ43YUzDMQJpTwNiiPyLjsITayF5Csh6wWX
         /UZ4YXaZRLg2NSbdscuY1g1vxmKTudr7C5jO0Fu7PGhTxvNoAEztyYpSm2ohz500lmkq
         rrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774189841; x=1774794641;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHK1YAHhATX+BOrgvNcOMGXM1iLk+EcLOH7Ra7adyWU=;
        b=BXEkVa6kME6u6xUm87pYa+RDjSkQKB+OyJpXcKFfTvSGM43t0pjVFvTTn5kdDrcXJc
         z1Anc/tzYmyWXmsad2/54CrkIRqW7zLE+egfag7Xt5SF9/hSNSk785uL6SYEcu6NEggl
         pfbHSYTZ7Mlk2Bvgz4pBKPYDIY70eaVoA6xnZcX7JxamMs820mhbrTwIRA3Qz9Z4S5Fy
         ANeRG8Dibe3eBY6wleKRQ1k6/CAQFBM0Wugf60jH+wh7mJ82uAQEInMt/m0nbX4NBfET
         x5FewB1p+JLV+sUncPOe7gqglC7E4O207JdbdZznexzJ9puCI7NdKkA40jHSHNLQV5k/
         TUug==
X-Forwarded-Encrypted: i=1; AJvYcCXvdxUlg02RBvkm19VV075kCClzEMyjr7Pgh1o/wXPtYNVUl403uiDw8RALMpt7dfClfdrfbnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcBz8o4PirCYAFnfBLSdYKyLHcp3nmjZgsdjlAJOc+cAd6f6u
	qRqMTldzHulNZDibXep1TX7Q55RPM3h2Az6pRNIs76LWdy7R6i4sUs7ACzSeVE/QFXY=
X-Gm-Gg: ATEYQzx0IPTWov2XndCv0mcAB77OlqPjtNrD0jI/Fkp4RkV6Sj/Ofo/0kh8XYnqJ1aX
	KaFZolU06PXd+DURbyTwCpWTzMEt0f8MvCkKYQUILM8inwAXsyvf4f9adcxDrXj5joiSbnRkqI+
	K2EqXVK1g1DY/WCPaOzuCfxHrkBIrIPSAYho0Ct1WQ6QoHVHNHsHNNUtR3POmNr5MAH9s7m2XBe
	n9QlRILOFYWgHNCfqGtdBBVUoGs9VmJUVm9ipVMySNdYHaNTyJa25RHXIhMa9Klc/BzgFyBRATY
	a2+AXNPb8JBme34G5zzBz79H3UYt4MctHS00q2rAzCUKRwkTtRsEjVQRnMnUt1DbBCrxvmUD84+
	acyzpyU3SiLU2K5TeA4MCsubgSJ4pN1Kn7uHPFLaYfj1ZAxWWYn3LbjY+S9bjDFtupMXkj+qHAy
	U4kvcWVncztcEcHbce8r+Qsf9ypv6mSxGQpNbTyvS7PyBHhd+frpe+tnffencFLFjxRNgVRswat
	RHX
X-Received: by 2002:a05:6808:c1b2:b0:467:4939:967f with SMTP id 5614622812f47-467e5fcc1fdmr5356813b6e.48.1774189840902;
        Sun, 22 Mar 2026 07:30:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14d64fbbsm6629011fac.9.2026.03.22.07.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 07:30:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: axboe@kernel.org, colyli@fnnas.com
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 Mingzhe Zou <mingzhe.zou@easystack.cn>, stable@vger.kernel.org
In-Reply-To: <20260322134102.480107-1-colyli@fnnas.com>
References: <20260322134102.480107-1-colyli@fnnas.com>
Subject: Re: [PATCH v2] bcache: fix cached_dev.sb_bio use-after-free and
 crash
Message-Id: <177418983975.306181.7832678653109865447.b4-ty@b4>
Date: Sun, 22 Mar 2026 08:30:39 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227839-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fnnas.com:email,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0D10C2E9AE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sun, 22 Mar 2026 21:41:02 +0800, colyli@fnnas.com wrote:
> In our production environment, we have received multiple crash reports
> regarding libceph, which have caught our attention:
> 
> ```
> [6888366.280350] Call Trace:
> [6888366.280452]  blk_update_request+0x14e/0x370
> [6888366.280561]  blk_mq_end_request+0x1a/0x130
> [6888366.280671]  rbd_img_handle_request+0x1a0/0x1b0 [rbd]
> [6888366.280792]  rbd_obj_handle_request+0x32/0x40 [rbd]
> [6888366.280903]  __complete_request+0x22/0x70 [libceph]
> [6888366.281032]  osd_dispatch+0x15e/0xb40 [libceph]
> [6888366.281164]  ? inet_recvmsg+0x5b/0xd0
> [6888366.281272]  ? ceph_tcp_recvmsg+0x6f/0xa0 [libceph]
> [6888366.281405]  ceph_con_process_message+0x79/0x140 [libceph]
> [6888366.281534]  ceph_con_v1_try_read+0x5d7/0xf30 [libceph]
> [6888366.281661]  ceph_con_workfn+0x329/0x680 [libceph]
> ```
> 
> [...]

Applied, thanks!

[1/1] bcache: fix cached_dev.sb_bio use-after-free and crash
      commit: b36478a1fece72b5d4540141fd31024dcba1d241

Best regards,
-- 
Jens Axboe




