Return-Path: <stable+bounces-204571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A655CF129C
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 18:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3B2F300A367
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A527FD4A;
	Sun,  4 Jan 2026 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="QyAZEGc+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DEF281532
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767547685; cv=none; b=QBw06B90lxY9DLQj3EaZ3CG0UfXA/QTtFq0WKUbnBAx24GwxBrcpHTy9v0YBZvOVuLeSzC9BIacP/Y/DXcT4plwqhYaOaOgH8hqsgJEqKSvdxXS3TEM8ET1KDGMCVFoTZgFmTMPsCUXhNmkBbIaDrPgYjXZZAYzr8FuQAaqbpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767547685; c=relaxed/simple;
	bh=6ZcchofEi36ThVNQ9UrQ1o1oKgDERRqmMyNsvSuL+vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDbwatG6wi2jOb71fkOsBJSzxoJRnvO9+mfPSH0JcvR5VhNcAQa3fZul3CO10rfBchjGTsaMjAmEOA48In5yJqycnWVb0fkixba3TTc9DTUdB6kuHHuAvz6ifqPajOyNPdEQ2OUdIz428mdzhT3CaXjS/+zQZ1hlNEgYadUBZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=QyAZEGc+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29f2d829667so26895505ad.0
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 09:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1767547684; x=1768152484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZcchofEi36ThVNQ9UrQ1o1oKgDERRqmMyNsvSuL+vk=;
        b=QyAZEGc+vQOoeqniX2XLgfUQbKXXQa+1dFFtQBLG5jCuHKfN4UKvm3Y5WpUd/Xkzt6
         CrbNxs8HU4ynTy/FZ4+apTsJ2qyMCbCnhzh2q00NeBttLBC1D6OnHRwVNDUzyjljusOu
         1ZkS47NfJAOlLcWmQUGg1QNsLAQsdQyZBo2DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767547684; x=1768152484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZcchofEi36ThVNQ9UrQ1o1oKgDERRqmMyNsvSuL+vk=;
        b=PYWHBycPtsno3tyBYA7ig7UzOxPYSg1IsDkrWc4Dd3+Hc9dPUz2EBM9VvsiFnoiP3K
         ZkFITBNqXndu6GHBJUajeBxQ12QxSvUY41C+h1eoQwb8niRBX8+ZwClsvloIUZG9aWc0
         3cKBVES60fOYf+Y0jh70vABD08H0Y8eMD/QAz7CBpiAzD2gVaolXP0AUunm5Ep6lXtOm
         i8C2hlPmMiRceFG9ZpEXA1PTeDLwIo8lUHtQH47ce1jM5iRCUCC2rf65y+fbWUJBUgdj
         J+GwZOjJCVVNFjmlmW0KM9f8RqEVAQ2GYJix6fFi5MogyRCpjxM/anKRJY62Ge0X28l3
         xZrw==
X-Forwarded-Encrypted: i=1; AJvYcCXal+IzTUuHniVyGYuaikxhH0x61Tn4qmKV5a5SMLzKL2Sh1t7KlCAMjSOwI98T/sFvRkTOba8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKX+D5sIJwrxjmk7PlNNYcTDM6ne6bQOQkJEe1zDn7gYCnmXo
	Uex7IBxA1iVfdrn24QOlVa0tKefr6c9m2FQeUK21yjYlKG0mJ2cLyRv3fQJUDfUxXhddfbk7DhO
	lAMlk
X-Gm-Gg: AY/fxX7k1vViy9XU2iy2O1Rum5brusS9Nj1CQXjHtjw1XYu1ogDiaXFBZNaguU1Jlrm
	WETaY1MU12PR188DSDH2fcHPGC8XA+vnG+u3k1tUW0VWB4EXoULA8VC3/74QenPfwVmivxa65e2
	P/ZA/kydRb5JyQsuChqGR4HJ7wisKocQ3MXBnCL48cSztOP4N/glEFpJFgfT+wq6rAC9PZzdyAQ
	Ce3RYWyW/gM/2uZO7orVpotgKeyE309Eveq+Fx8eKoAG5pQ73F/tDZUEB7OEDyyVVhSzxUtfWAy
	k9kYi5mJreyYeSZXWlVSYfI8IlZ/k06TGf8UfRL2iJme+F9kzF6t4lD3YQMmMjHBzVGngv9yYhQ
	kUN7KrOyX76lQzn8GtFSog3Wm/Kwb0T6VEBa4DZQUHhth3FN3aUUj8n0iol356EBOMYC3h4J51g
	cft+WBflB65RpsJuxjb0ArDg==
X-Google-Smtp-Source: AGHT+IHl4Qeq6HwnHxtUaqW3lTf/RsDSALJ3wkpesclzkqfWQ2AOQqIxOJaZsF2WFTVAX/CKCSP8bw==
X-Received: by 2002:a17:90b:4d8e:b0:343:e480:49f1 with SMTP id 98e67ed59e1d1-34e921c4431mr31241161a91.5.1767547683907;
        Sun, 04 Jan 2026 09:28:03 -0800 (PST)
Received: from MVIN00229.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c7263a3sm39368371a12.32.2026.01.04.09.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 09:28:03 -0800 (PST)
From: skulkarni@mvista.com
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: syoshida@redhat.com,
	syzkaller@googlegroups.com,
	pabeni@redhat.com
Subject: [PATCH 5.15.y 5.10.y] ipv4: Fix uninit-value access in __ip_make_skb()
Date: Sun,  4 Jan 2026 22:57:34 +0530
Message-Id: <20260104172733.1913006-1-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251225155236.1881304-1-skulkarni@mvista.com>
References: <20251225155236.1881304-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha,

Can you please consider this patch for the 5.10.y and 5.15.y stable kernel trees, if there are no problems detected with the patch.

Thanks,
Shubham

