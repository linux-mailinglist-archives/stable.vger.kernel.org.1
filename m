Return-Path: <stable+bounces-247243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMqbClX4BWqcdwIAu9opvQ
	(envelope-from <stable+bounces-247243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:29:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F193544AE8
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5857D306008C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A878A3376A9;
	Thu, 14 May 2026 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVmndN77"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E00C314B96
	for <stable@vger.kernel.org>; Thu, 14 May 2026 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776028; cv=none; b=DMcjU479z/TUzuqpDcgtO5mo3gKntumR+AwGShdwnPJiJKZLhf1W2zsxAcuCMI5Z/gl+3H7N+yreRjEHtkCB/Jtw573/5vvA4Ui7Fmr1YqbPYiOT0CS7l0btapbIOnj6tkQ3gGPMnOtZgpchfxgP1dBIFHnDTQ/E+RPE2FX7u5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776028; c=relaxed/simple;
	bh=o1KSLUq01z7K5ql9SzILYtCri7hH5p1yg8C13g2T4Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwqLHcDrWFvxSUmidIiRCK/hgz4m910S/MXVaynTEiWGTwakjaLOYrKT4wsp1ZG+biTogmBSp8I2PDDXCA1gFooMg33pdq/ozGctKOny7FDhCIUWBBU0+/RsEKZpX1spn8sMfStVNjfKTPOJ6aLtxCJ6sdCb94lwqXt1w2nVYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVmndN77; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-392445f11c5so102761fa.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778776025; x=1779380825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1KSLUq01z7K5ql9SzILYtCri7hH5p1yg8C13g2T4Vg=;
        b=FVmndN77XhwgpM5VJXJAJbNU3+2jBSgL0KeYculltEKdRfWQORWR9ZuiMoxXvtwVMe
         Wkmq2XKSv1/lXzx/7z8V3sQ2ujF2jt1Sg1symvLElofQrSNYbqvBCOwL0CAZKagbIO29
         pwnZEQpCzsy1x0uZ9DsBhCZix2nypqJJK0628jlB1h2iSy8nitYc1eWEucLrpzapv7oM
         QNvYBWFvZRVA8YYrp28VLPl1eXbbOPNcJW3L35PRdb5ltOrB0u7TS0JaRcWLAF+OA0v1
         M+aT308KSccHAo6LWZ66MwFr55B6eDMjKwoHEUEFhHk/gS38M2abdvtc/h8uolcKrtcA
         YW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776025; x=1779380825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o1KSLUq01z7K5ql9SzILYtCri7hH5p1yg8C13g2T4Vg=;
        b=rO7d4H5oPcZIJS55PIjoiVi1uNEyzKQEuVjVLrywFUJcg7hHqZWdo5vp86rWMR1XUo
         p6+MtQIz9cPIUEdzRAk0gJ/y58AyjmwRJYs/PL050nqSDc5JeIOKxoayCI4APPrMvcgE
         7IABm88JUVibl2foRkp7o+wEwjvkGpYkiYhiiDAMdAf5pus+/Vm6svt5Xzkw7Z5twUpK
         04PqEA/rVqT2oYzGbeJfw1bUttOB3XJTwUd1u+Yq+3CLs2F9U5eYB64jiZuIqojlhCf5
         MXhbmdVefRnAeC/4j+rcsjVywHQiaYcjQ6ekkfPO3BGSeGehIAo0kheu35Nr/YQWHITu
         qd4A==
X-Forwarded-Encrypted: i=1; AFNElJ/2sYgjLDcyPBesEyInOvCB3HF+WZCWIC3tT+DhKsdHp5cikFewcFJFG4QbBtyQYFCLje67Jfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrxBQVHDbXFGLaL3DPk9tR/tzWbDsib8qYRKCBGYg04KbZbHyN
	eJd6ZRYEAOoDIL2M57dQvbBhBlUYj81JuLRfrMHnQXZw08mxCGtYkNELopMoum4hJAj4KFeidzQ
	=
X-Gm-Gg: Acq92OHA1r5sQrtzquzUNTi4vFxDEk0IjghD6f512/uGL97V8e2SFE0GsK/d5WjzdnV
	gdoTGbdzjdLzVe20m2NGk81LstHXtjZv0xhYMvHyCcJ1xsxw3NR/00QFA1Y61yaRb9M1DECK8m2
	PVkI7MvD/XkbnbWVrBKfjWyMkCXsQiWyfeCd64PdtdaQuJukvBAHEbS6CjTIXN6igmXdVoNTDxf
	rtbb3xR3JkosWg/wr3XYHNBMkWIgrtLf47YBT64Q9756lQ9agehh4yw/CETHMkVZbnOkn5UGhw5
	SyDD1GxGaoDHVvjk/+R66c6d4uBRvZvK+1x00jojehwSmZRBg/UmZ/ftZ3rvIjkMdx5U1DmIjQs
	PXSKVvzSsPuajAPjqUzp5xypOEVsUhqxOmU6tMP9ba3Vr/iJYHqPvny7JX4lVfsO4mby31L/kaG
	aYeJG5SF5teKjTaL3nyqQ1dT0N1lnDXj30QfevhcOdeVQjwa2jgY7eNRRKyxzTBCfV4G+zsVc=
X-Received: by 2002:a2e:b8d3:0:b0:393:cbfb:6f1c with SMTP id 38308e7fff4ca-39560a47f27mr693481fa.14.1778776024946;
        Thu, 14 May 2026 09:27:04 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945c8ffb31sm7418201fa.18.2026.05.14.09.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:27:04 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Valery Borovsky <vebohr@gmail.com>
Subject: Re: [PATCH v3] mfd: sm501: fix reference leak on failed device registration
Date: Thu, 14 May 2026 19:26:59 +0300
Message-ID: <20260514162702.323388-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506154040.672860-1-vebohr@gmail.com>
References: <20260506154040.672860-1-vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F193544AE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-247243-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

Hi Lee,

Great, thanks for picking it up — confirmed on my end.

For context: an earlier version of this patch ended up briefly in mtd/next
by accident (Miquel applied it to the wrong tree, then dropped it), so I
appreciate you taking it directly into MFD.

Best,
Valery

