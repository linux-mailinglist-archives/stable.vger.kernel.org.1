Return-Path: <stable+bounces-52298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6A909A98
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 01:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F2B2829EE
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA3E381A1;
	Sat, 15 Jun 2024 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="CdU6qF/I"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A405535A4
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718494123; cv=none; b=dj31a8GV+pE9tt5I74wikK1PCqVmOSKmBo7XQNDfo9sDK93jAno/8w3h6LLMEsaN0ykFUSqrhI8EaJ+HrRbmp0P/v6+pjuqggoMMvspm0x1N8xA1A4qVZGnl8qCJPrbYsydia5wwBE3cs347P7IbNS8JrVUKdZi3sAB31wSiw0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718494123; c=relaxed/simple;
	bh=PuhCSCB7z1hRNvcv0V8Th82ExCypjZhFUP/vuuVSejw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Q9ieOMzmOx4jAhMuBwkdei8Tuuh7JK8bXO1d+rMWtiZrPmJDMXQtmQyzxZ8I+BcXepF002Av8A/DmlEXSktAp07aRVkzkfamK3Eg5LZUqRRZMAuow6rzTpr9GipLZQ6dXsBb4uM5bQ5pnBcFntgdx4isl8Rx3wy28o76Lp+n8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=CdU6qF/I; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-37594abcee7so12530825ab.0
        for <stable@vger.kernel.org>; Sat, 15 Jun 2024 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1718494121; x=1719098921; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bVJfiDf/Gqgji1BB4JSLRisb0WA0Jj3PX94tszW1XBI=;
        b=CdU6qF/Ij+FO03fmsk68CB/WwX3B7iB/p/QhKvZTfglEjuJP85wBSaoSa6IPQGLhWv
         SghaWfeUv98jlPfX9LHOjBplucf1/F+oua/0vsc4HzRSNio0DIVGsvciexLtkrdtP57O
         8EQsElYoFqC8HrOYEtMQoDqnPRmNA2IiYvuGaCRqaobFXgz11wRS9PRGUyVpiy5KkT4a
         7mr0CPBY99dhpkWjXZf9MCkjJOUjXg9kUQzdSnBZnDZrgOcnJM0U1nHI/ew6ov+D+1q4
         hI0U89cMOG3lT5P2xWpvfprh8emAqWsYQ3LF0t3ODWrOETgAxL4OzZ6SrwS5lOtjVBFK
         LTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718494121; x=1719098921;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVJfiDf/Gqgji1BB4JSLRisb0WA0Jj3PX94tszW1XBI=;
        b=CNO9unAz0Ho2CJmuhR9rCnp/lXHe1glSFnwC/84uolwvOPWKGxepfVG41+ArGjwkeU
         idq6iWFWWzQJ3N6TlqdCTuIXel1HyHGp4rHfGn3r6ho3tK/ALBz5qCCaorsSNEtpNSC1
         yJIXaRzyLqJGMKepKRRq8QKfZFUZQEkG31fOF7WPqYSFcrEibAsJlwgOBhK6VP+1Zi+Y
         wEMv7N7PuvgGTpq+J2RpF1VCIvl9SNp8fHbbsAdzP1+xsYQ0AsUgC4GsAwHlAu1QFAqm
         SA1fTPvKSVL+Aq1Ebnnf4MUxbk4hkBkJqD5XpaVH+J3iSV+XZ1vkZzPN/Ku72ZkrzqCU
         s6lw==
X-Gm-Message-State: AOJu0YxmNTHGh5A7G66rM1I6TIYMZfF5A+CvX8Hsl9RvrTNiO96Iln1b
	HYZ/kjlvnRPytBpeHwxiYeYGb5/e1JnUXJr3iPtbpizQgXQ8le6PvXqv5CnftEDR7fSdh9rALlZ
	MNtPDvWhnjhaH431jfZ/LKW4IBLisJt9z+GGChieQ8YrpkCyRUL0=
X-Google-Smtp-Source: AGHT+IGu07XolmiuxASUua82RrugL8ynOig/0q3dOGYG/nr1ruTYIb3tuzONAWmrJB3qUm8hwYXgSsWPyqHStGW/jJk=
X-Received: by 2002:a05:6e02:18ce:b0:375:8b0e:4442 with SMTP id
 e9e14a558f8ab-375e0e2f857mr68204995ab.19.1718494121227; Sat, 15 Jun 2024
 16:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ronnie Sahlberg <rsahlberg@ciq.com>
Date: Sat, 15 Jun 2024 19:28:30 -0400
Message-ID: <CAK4epfyJJKm6kShw9Fa0dA=ns3CK8wjA4v236nRfubxfibnRFw@mail.gmail.com>
Subject: Candidates for stable v6.9..v6.10-rc3 NULL pointers
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Manually checked list of commits in upstream that mention NULL pointers and
that reference that they fix a commit that is in linux-running-stable.

a9b9741854a9fe9df948
c4ab9da85b9df3692f86
c44711b78608c98a3e6b
0dcc53abf58d572d34c5
445c0b69c72903528fdf
97ab3e8eec0ce79d9e26
47558cbaa842c4561d08
62cbabc6fd228e62daff
02367f52901932674ff2

-- 
Ronnie Sahlberg [Principal Software Engineer, Linux]

P 775 384 8203 | E [email] | W ciq.com

