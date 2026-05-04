Return-Path: <stable+bounces-243900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BIbEULs+Gmi3AIAu9opvQ
	(envelope-from <stable+bounces-243900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 20:58:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBBC4C2D5B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 20:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D288E301E593
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7FB3E7140;
	Mon,  4 May 2026 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUUPCm9J"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75B3E6383
	for <stable@vger.kernel.org>; Mon,  4 May 2026 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921086; cv=none; b=rP+rjbsO+7GAYs14bmZAWtNK3SKiGHOORe/T/8flJLgz9PA4Q8NgdqHUdNNcx+YvkfEWSKMoIaK5upLo1OMj5UaBTRjWDXx9tq23a0V7D+yaMqS0JOvlfhf1Cm2WaKxzYFHCprs5scPop8HX7jbaoVAyjlzqMsO9TNc1nkCj1QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921086; c=relaxed/simple;
	bh=9vldQQyQ8QxWej/+LrSPmubE4dYlmF8mGkXkRZBWrLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7Xuv/3FrlUXqIzoSThjebi7bko5R3cGhBkmSHI2NDYDq5AWx4egQy5RAiPCyV+jFvb1MNfe3PGZavoRKhiteKzaTRflT2iE8dVC1+iWAHAYpNzOa3YFtFyWk29ZV1Rl2HqQ+kgYfPsHFGh8Eg7PsLstWIs1DUVxXd8lkcv03+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUUPCm9J; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d102471a4so10595315e9.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777921083; x=1778525883; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vldQQyQ8QxWej/+LrSPmubE4dYlmF8mGkXkRZBWrLw=;
        b=PUUPCm9Jl28zkak9ZZwLahKcQ/XFEhJfbOtWPjAlkGnusPRP6OXskE8Hi6LviIOQBy
         OVsbRZjie0AL+8fwAiOM3Romp9xHDWiU7hLXDCf+WxeZfo9tXnHYQUceFwokT7iXRYRO
         qaKYwY/mUC232xlJ8b9Mcz1gHo6a1IJ0v1qU+mhMTbXoKwZz9mU4j3duCQAnOCVwSHHV
         tSXsARWB2VpfvSWU/gYdHBWrhrPt9H5sWYmicaIO9y0+E6xjUFWMlMAyPMmL72AqvRcy
         wSVYVPDaes2ZVGKL4xKOzbzxGB8KSNxqnJjXIfvmk8zRIyi8DUJrPOAAVcXNCstR1lxm
         YQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777921083; x=1778525883;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9vldQQyQ8QxWej/+LrSPmubE4dYlmF8mGkXkRZBWrLw=;
        b=bhGMhbGXBwLqHAZbl9kfDV/p5tTCqJd3i8bu5xMmH+ofBasJKvo5UxjioKCF/OF19L
         P5lujyGL3dVcjo/eh1gykDWRQkN7DkTCQesL1/9Wd795PYYZuwaPOzGntXKv5YfZOUoS
         l6rFagzn46H+vRQZz7XpGEKnL9PEYkbge1s6Z5WK7+SDm8xhF68TTNoRkPKmspxFMGIy
         TV9vxx+0yo1HvwFLcE6JO9/CYXtJEABM2Sya1nBRf8qP1K6Ult1oMb68x8E0T7gj40dj
         9afKeHvKM42G0jAs7exTiJTxSeKflU+SeFUgtwYwO4RLL8T7JCSWXgaR/tQFHrsrYBbr
         ZIHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nw2jwXRJGHpsVejCcNs6QNzSY/RcpxOH3fof6EXSCpwonkx36EL+Zg0l4geH3ej9jw6Hg19Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxybQawV5jZY8U0MKxgDYFbxytkc0fRf+u5uDrpE/xneHwRyXTv
	yToJfjbBBwk6QPGEpqWH5UmOFplavZatU+rjNI/wGnWcjh9TyO3xWBY=
X-Gm-Gg: AeBDiesFDRTiJYYNYlQmUBTRyo9CmXq276Wur+UDCrgiv2i8UKRjIkdlTWIBg1xQYYH
	p74DxfaKIcMztoSZgh59WTKz5CpdzGN9fznEHMd+CAu6iUq229lRqx5bHKHY2RDwNzgnFTSesN8
	clCgR20UCXdzRJ2b6FoR+7E95/p1FUIg9R+TNtUwcv+zYxv7qGfPGG2Uz1CUU9LCtsJpRbHcOVP
	3PlhHDPQKbey3UJDxEm5hRQMhjjVzleVlr2Qkk14WG2aSMTcCcG/kTwyjYtg1SCqI5e503fu8hW
	yFlpd4w0H50r2Ub4v0zbwQ/Oou1PDVk5Knlglqjlv9Zc4CCvBXVu/44B+FY6XnvjP7wTofpxNuQ
	ohTUG6H/X830tIznORVULFDjE6PRaDzhIBvs7XwMrVRVet8LCGuMdN17jAhoe1lS86h1Y/K9WrD
	7wim40y1KwPjM=
X-Received: by 2002:a05:600c:c058:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48a9886c2aemr107986535e9.6.1777921082958;
        Mon, 04 May 2026 11:58:02 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ff04927sm102793425e9.36.2026.05.04.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:58:02 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com,
 syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Subject: Re: [PATCH] gfs2: fix use-after-free in gfs2_qd_dealloc
Date: Mon, 04 May 2026 18:58:01 -0000
Message-ID: <177792108170.2736561.9192653094415898517@gmail.com>
In-Reply-To:
 <CAHc6FU6drG2y+dD-gkuq52uKUXzdGzBA6dNiwPe79-SF9J2hvg@mail.gmail.com>
References: <20260501110203.18771-1-tristmd@gmail.com>
 <CAHc6FU6drG2y+dD-gkuq52uKUXzdGzBA6dNiwPe79-SF9J2hvg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: CEBBC4C2D5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243900-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,42a37bf8045847d8f9d2];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Thanks, Andreas.

Thanks,
Tristan

