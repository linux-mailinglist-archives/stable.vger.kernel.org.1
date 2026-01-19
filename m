Return-Path: <stable+bounces-210327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE392D3A742
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B7143008DDA
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850E031690D;
	Mon, 19 Jan 2026 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jakstys.lt header.i=@jakstys.lt header.b="E/yjlMVD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02427E07E
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823203; cv=none; b=a8/DlGraematxr0Gxd+4n6fYT+7Y1u9hxxAtpFy7MVUeMfrf3tS1nWvnwglWvA0qvp/uAPiMVe2qO1IcWHBAtT5PpX/T/9xbe+FMIpvbGT2KdQzok0CT1CADQWKZk/hQMDwfwhX25y1X0R50tLgDVKnsW+rq/sJAaY4KvBVHVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823203; c=relaxed/simple;
	bh=W9tl5EGVQQ07JDbhxz9J9n5G9/s3ivfYD8n0emvwRYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLehELvxwscTaONJvBqdbOet/kM3Jtea+Bn6YonM1GrfQ3lW0k6tnniCJWaoFsyjH0++RE+73/QDQN06vJl1LBg1VIQQ5Chna1VAfJxIrtQzvZzC7F4bhWc1mA+qH2k0nyWg6Aca03uQ0G+1E1mTwYQH9bo6nEtk31KpzCzaWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jakstys.lt; spf=pass smtp.mailfrom=jakstys.lt; dkim=pass (2048-bit key) header.d=jakstys.lt header.i=@jakstys.lt header.b=E/yjlMVD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jakstys.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jakstys.lt
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b874c00a39fso744760466b.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jakstys.lt; s=google; t=1768823199; x=1769427999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9tl5EGVQQ07JDbhxz9J9n5G9/s3ivfYD8n0emvwRYM=;
        b=E/yjlMVDmXUx+e77Rvjvj0Ti+rKdiQn6tAo3dlK3kpStIpSzRlrn1BFJEcr5RpWZx3
         d3cjPHABz+k7bL+siAuiQU8Unygx0tHIIDEnWRj/rjWt/VeCzlLzFlkWdCFx+rRk5ooy
         1R6S+FouZXqidTNP5D08ZwAaCz4KcsJeD/tgdc+D1jPJOQZSHl93oVKx7X5jhURgeWDQ
         VEIBXzJMStTZxTNuLOGOj+uQutHP4rNIK34R+IRADeRZ6tbHNYFgroznOWKOjyVU9PZ+
         CoYyNBcoHnTGl3gHn4HVDeXCbc6QMNgQw12D/K+OObpLxU/T/rDQcU0qEZFpO3Y7Zltq
         1xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823199; x=1769427999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W9tl5EGVQQ07JDbhxz9J9n5G9/s3ivfYD8n0emvwRYM=;
        b=R/KgjXcWOMIoO4MxHas7QXsmLiNDhJcB9YyfQ9QkDfzJ+iHw0S9ClrxVIgj8LmvByR
         3p1jOhoPW2/akAIP8TjY+LIVWBWUJOXsS3wUmzeYs2M60BFlzNpXfCl40Cv3uCP9mBEh
         8b5mAXo/9PLwQXNUgx/shbnOf2JFAL7yEWCCe0GrGRWcDtV+wFY77vFrGgMXG6DT1V0o
         HvwH0bv/a9VKSf+p3gh2x3blbO3QEbinmtNAcUcchgVf8VwSuCRStSl9ek1DGgm3guQ0
         yIK37HwjIgWLGxfQDBJN/uyl4mioAmXa0YT+F+0UfyiomIbGXnWlH+lzQXJ50sknDG1D
         Vsqw==
X-Forwarded-Encrypted: i=1; AJvYcCWyCzYiLo+3N6UyRsE6AynOrzsj8HoVIh+H1XhN3tdTbgLKFHtMfwa8xNmMfT0jmAhPz1frSSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzssB140wEzoAZnTkXXkUx2BOYXdJRgkFVZK6wC3ooreD6zUEIH
	M+/0JoW8sPlcTN1mUUMD/OZ9xa3HpVz1M97bDNkq3oFaQeZ8vve7IECUNQx8gazDew==
X-Gm-Gg: AY/fxX70N2ay1RovgyQeZ2KGPXar170Dh+0rs6riFHt6359ONApANznrl+7jeR3nn9r
	12pzQOZwqmEt2MnPbvqCfqm4GThpcdmOI4Noh8L32xXktFB43OLM/iwUFzZ04nb2O630YnDpB93
	NzCzqcZEPryPsFTcPTejxyLRzuukFD8IZ4tKyjf6JDclE3a0R11yyMT05ZnzEnUXbrdzfvYRz0z
	Xons5+QUuUps09H3qNdDg7tjOS+yh/PwCSP9VqN6FpKSS3sE9RHUmmbXfX0Wy+++kRudX1qsgKx
	+QHtaadmpnpnDldSUzJvRS5OH/27kqIym7eCe9JnEgjr/cXNbM5IHunUtbtyY0s8ZotpqGiY/Tk
	GvM0/Azjw2A38XJQ3bmvi86AFZ8qs9Q3V/jkQFAyHqL7E9cwdeocn7kemu0rI1/0lsbAmt+xn3I
	QL7A0pUhXiI7RLBmSzAl+NRruatNncE+rFvs0NXserUO8qkrEMJLtnrUPnDekcwChoW+9/sRRHs
	AB6qWaWkQOj0jf9wfzwxsK2yO9SrDw=
X-Received: by 2002:a17:907:9694:b0:b87:191f:4fab with SMTP id a640c23a62f3a-b8793a23490mr1008761666b.26.1768823198863;
        Mon, 19 Jan 2026 03:46:38 -0800 (PST)
Received: from localhost ([185.104.176.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879e2c1be7sm999058266b.67.2026.01.19.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:46:38 -0800 (PST)
From: =?UTF-8?q?Motiejus=20Jak=C5=A1tys?= <motiejus@jakstys.lt>
To: sashal@kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	fdmanana@suse.com,
	linux-btrfs@vger.kernel.org,
	patches@lists.linux.dev,
	robbieko@synology.com,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] btrfs: fix deadlock in wait_current_trans() due to ignored transaction type
Date: Mon, 19 Jan 2026 13:46:26 +0200
Message-ID: <20260119114626.1877729-1-motiejus@jakstys.lt>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260112145840.724774-5-sashal@kernel.org>
References: <20260112145840.724774-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear stable maintainers,

I was about to submit to stable@, but found this earlier email autosel.
However, I don't see it in the queue. What's the right process to get it
included to stable?

This specific patch fixes a production issue: we saw this happening at
least 3 times (across a few thousand servers over the past 4 months
we've moved to btrfs); the last time I was able to capture a kernel
stack trace, which was identical to the one in the patch.

Thanks,
Motiejus

