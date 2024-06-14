Return-Path: <stable+bounces-52240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786559094AF
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 01:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE6E280A4B
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 23:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0118C32C;
	Fri, 14 Jun 2024 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="c9w2arKU"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B910A18C348
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406679; cv=none; b=HepGQ7nJRLiK/sTYruwIxv4GCtLK8AuybXt3KmDMy4vM+0vRKS0ZOX/S+5k87VQaHG/8Mt7HRRFjpa4EivGKMv/qea5MNY9p+Isw36i7k9z8ELB4YSVzx/EFFo76eio9/qVuz8Rc8F7VUBOKbgconDVS0yJ70WceMItTxisYTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406679; c=relaxed/simple;
	bh=FFyapRmSSyW1CLQkBO2GEbj+7FxqExvhzIpYhs/A7Hs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aW4ZimO5erzukeiPwgWIh1W/tysMvO1502QwI9BNa1ZUQWrj1t1pwkzNJR1hGD7tZI9jQlM1Ey/uqi8STgJhuFmDuBmj7/DIka6/rJ1aQeQfDm8ngu5Rq8JJTMHG5Atda4x3AeW4D5jteC7YAKMu0QncTiBXSfLNN0omjHXVy1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=c9w2arKU; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-374528b81ddso9899245ab.2
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 16:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1718406676; x=1719011476; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=didEg5dfZF2NQvHzjYx6JSU78f/0O+pRfGHWENOGIx8=;
        b=c9w2arKUuZ4ttml8/DiTPbbpx58+RjAiFVi+yuIBNxi/By7leaUGgl4YwItOYX6CrJ
         wFT3mePlQiD4WrN3O07obbbeY6j34nhFNo8F4Sxr0D1AUSesCVkdSTwdw9+AgBqevoxO
         qFJBQ5qBXJuUD7R1B7tvxchN3JvFjasoJC9lBPcc2cVQPWgfNngAQAgNBbfokLjVppwn
         aauIoQCy/c5vKzHdytF75IBCi/KaeOGees4xUrzqFCEY9TrhoJZ7BvGC8asFVvWh3Qya
         Bp7POSF9g+Qevq+btq+mysaGFXBTqrFXY6puGaxVrfhgyF0sZ45+0vEBxdqg3on9WWA4
         +Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406676; x=1719011476;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=didEg5dfZF2NQvHzjYx6JSU78f/0O+pRfGHWENOGIx8=;
        b=c8LZ077SOAsqDhmfhXsstjHBVs9ODoGhd8WjjnZT5A8r30CM23MBN3dLp8+RPvpVZc
         iYxuL5+OUIezEzjQ/3beWQTnVILAMcrX0I51BM/9h5MC0SBXeAlK1TXvw1dZFT98l2if
         t3kMOfr3+YLLA9wCcfjqnK7ao8itKp7D+W7L+9w36gYTIrijAlxwKSkn3bJtJ4FBm1Hm
         dm6PlITASBvD306Ry8REfoRH0Ebpku/r1hcX3RnMf63Ehdhh6iP8z3x8ZuGSQvtRbL3k
         P2vkonQU22qtP9zT3m7z2eDjciy7wWm8qhfC4RLnpiwLK48w8H3ZRPiiv/i20byQnZSn
         Xi/w==
X-Gm-Message-State: AOJu0Ywe+uD53EhWexaXOrnAbgCdqrUPaRBYiH/sJVo/JhohKC2seQ3F
	pn152lyQ5O9XG8cX/kVBH48ni39X5ZUn9tEKaC4M4ohJ7B2uYVOot3Ljj7vgwiuKV1wNYGcRFYZ
	qgfXGhCaG77Etth+SOOzi150WePslzHPR2bQNM7uX5Ooi3f7NNB8=
X-Google-Smtp-Source: AGHT+IF43M7dfarPMBgLgxX1erp6obfWSvTgtLshP7M7Al/pXM8x2pDF2m2Dr5XEA3K29ALq9p4HSZc+Q201UgKEKLc=
X-Received: by 2002:a05:6e02:1fc9:b0:375:aaa4:4243 with SMTP id
 e9e14a558f8ab-375e0e12bc1mr49196365ab.2.1718406676557; Fri, 14 Jun 2024
 16:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ronnie Sahlberg <rsahlberg@ciq.com>
Date: Fri, 14 Jun 2024 19:11:04 -0400
Message-ID: <CAK4epfx_PohoB=QwKb96NE6yOFX1U3LYCAnfdZumaJT_qSan_g@mail.gmail.com>
Subject: Candidates for stable v6.9..v6.10-rc3 Use after free
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Here is a list of potential Use after free that are not yet in
linux-running-stable
The list has been manually pruned and I believe they are all genuine issues.

546ceb1dfdac866648ec
36c92936e868601fa1f4
4e7aaa6b82d63e8ddcbf
2884dc7d08d98a89d8d6
166fcf86cd34e15c7f38
4b4391e77a6bf24cba2e
da4a827416066191aafe
de3e26f9e5b76fc62807
0fc75c5940fa634d84e6
647535760a00a854c185
a4edf675ba3357f60e2e
90e823498881fb8a91d8
2c6b531020f0590db3b6
7172dc93d621d5dc302d
86735b57c905e775f05d
795bb82d12a16a4cee42
2ecd487b670fcbb1ad48


-- 
Ronnie Sahlberg [Principal Software Engineer, Linux]

P 775 384 8203 | E [email] | W ciq.com

