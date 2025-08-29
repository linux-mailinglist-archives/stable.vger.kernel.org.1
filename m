Return-Path: <stable+bounces-176722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED894B3C161
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF363B9767
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 16:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F88E335BB1;
	Fri, 29 Aug 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/h/Jw1S"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFEE283FDE
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486651; cv=none; b=K2HFpstU57kIr4xpVBNg5VKdNNz4nYpy7rIvG4Xh3WxoGlZ7u2aTI7i4llYulZIuFdZTtvNWV9/naSbG5+jAHg2PgWfW6TjiiZ//SGKE6cdpdSNjyruXf8waKYc6A5Ih8+M2Tcag4+CipQs9GArfNvN+KY4HBWLvx1fEhqVjOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486651; c=relaxed/simple;
	bh=rMY9CK3FzyWL5hcZjlKfSIoe7gfxKfxrpr7JgBhZVPg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X9ktjCTzF8UXK2W08wcDhf73J6ruRMIm1bFwqfxCOLjyu4UzPrZ+thjx3j9T3F1mcaRsdu5z/2kk7FW1RWR+LQawTMHObqiNdAnMrWfcWqpp+NKGnnchgU7dX3VuUtoEq9YwVeyA2eViJM5E/B2LETWF/vWJj1dwsOPpW/X36UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/h/Jw1S; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f6bb0a364so796631e87.1
        for <stable@vger.kernel.org>; Fri, 29 Aug 2025 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756486648; x=1757091448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMY9CK3FzyWL5hcZjlKfSIoe7gfxKfxrpr7JgBhZVPg=;
        b=H/h/Jw1SzFqaEKaiIixIIK01Lz7IxmjpURBKAlaVHq3mUgEvxXAgEdbcvIrrVGc0V9
         tnd82medqCL1d5+eyiFOu1lzwNfaqp72/MqBqAfm8eexH4VsufuEaXhahhuuQy2x/UYc
         c0QinNK+Xb22kItoqNMmRYVVKM+I9dLB0OQsYlCaFqojVHDlKoM7EkkLZfRMDP5vKx4B
         i32pOMKUHCOhSHaiJtbiPEXvJMY6y9ffCN0pp86RjKuqjbTtJDft99nT01RiLGS7NIv6
         LMU7NTFV/ukBpKUdAutW0uLTToFqk2C7uNhPnc8lu0BYRUU+aeMJoNqYDYXJchIFFV2b
         yVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756486648; x=1757091448;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMY9CK3FzyWL5hcZjlKfSIoe7gfxKfxrpr7JgBhZVPg=;
        b=HUk8miRvCftXl/zwPRhEI6WcE12aWISLk1ArcGNvNAGuNOuggcUuPBC7A9YWMiTgLO
         RMHQ7bsPlcEPI3AWF3Hq43fY6r5h0M99n9SVFhGIXqeVUWYb5uYID+A/4T6zn07bd8BR
         hWWngSsTxoGCpMhM2Xh6kiJkTcjmUzyqZAtcBPE8iGaqKKmQPTDoqOMr/1DknJuATMQH
         H4M9Yw2pOwLPCuoZm5aPgF+lt7FOl5A7vzXiSBQK/5WjEl2mBNHVx4Or+E4HgQ6+YDnX
         A+MArzchyizNz1kBTRn/lfGUxQtqHrYxgelk9b3O5ySsPDV69DzoyxQuLNh+b2kTDcCu
         CSpQ==
X-Gm-Message-State: AOJu0YwDJ5W6MLk+EJvnK0S+N+DQguLgs/Qn+3mXzxvP4lE9br1FNJA2
	aaPmjQx/JXUstRgUB6M25+qHHJb7e6izgW29bY+PoPAqDeRmmtDuR9iHQIAFZgLyR4gKQatpqMI
	tEqRlTI6PHy5nR2mThMBQFiYOEGAfWXg=
X-Gm-Gg: ASbGnct+GlaPYnOD9GYIw9C1cpyBHZYfOI0RTnTQ68JL9R3RtbLgNHT4QySXQC/+G2b
	A/r2R6w5Ao1jib0Xiis/DViuMvCbWEaKh5Ey9IxHGc3hBM0H1zLEI5lve+2ODpCJ0h4HMV/OjZt
	5SN+nsu8A3wY+8XU/n8rcvU+9hMX2nityJ0Qw2qkhU55qbZqzKQvXsVmc/9OiRzJyy7s877++lj
	uHbutvyBD9acWQzggCs
X-Google-Smtp-Source: AGHT+IGcw5eRtwwB6jNfxVcLXIsPGYbwUz4mW0XmcZkL8XVoLP7FN/i1ZY6JtTOG9mR5bbvMKURCsKG+woYi/lDOX+Y=
X-Received: by 2002:a05:6512:6082:b0:55f:553d:2b83 with SMTP id
 2adb3069b0e04-55f553d2ea6mr3179032e87.54.1756486647605; Fri, 29 Aug 2025
 09:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 29 Aug 2025 18:56:52 +0200
X-Gm-Features: Ac12FXw8MPs7Rvl1AoAM4XDl01SD-oI-RuX4Acg7EVXtc4_8rDfMZU5S3_wwOy4
Message-ID: <CA+icZUWXiz1kqR6omufFwByQ9dD9m=-UYY9JghVQnbGD2NMy1w@mail.gmail.com>
Subject: [stable-6.16|lts-6.12] net: ipv4: fix regression in local-broadcast routes
To: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Oscar Maes <oscmaes92@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Brett A C Sheffield <bacs@librecast.net>, Salvatore Bonaccorso <carnil@debian.org>
Content-Type: text/plain; charset="UTF-8"

Hi Sasha and Greg,

Salvatore Bonaccorso <carnil@debian.org> from Debian Kernel Team
included this regression-fix already.

Upstream commit 5189446ba995556eaa3755a6e875bc06675b88bd
"net: ipv4: fix regression in local-broadcast routes"

As far as I have seen this should be included in stable-6.16 and
LTS-6.12 (for other stable branches I simply have no interest - please
double-check).

I am sure Sasha's new kernel-patch-AI tool has catched this - just
kindly inform you.

Thanks.

Best regards,
-Sedat-

https://salsa.debian.org/kernel-team/linux/-/commit/194de383c5cd5e8c22cadfc487b5f8e153a28b11
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5189446ba995556eaa3755a6e875bc06675b88bd

