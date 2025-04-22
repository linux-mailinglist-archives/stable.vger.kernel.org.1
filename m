Return-Path: <stable+bounces-135007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188DCA95DB8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC61D3B627F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C57119ADA6;
	Tue, 22 Apr 2025 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIAUuZnw"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861C7DA6D
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301909; cv=none; b=rQDG/u3b3JL9DeZqhjg6vTc4H/5Wccm+IstmIwK/AQrcR34RPK2/NbsXhdw5vz4SH0CEFH6jYebFvGtvNOOjM4zrvBOY/KlxooA/ttzj/aj0GF9ckLeYrjgkaWZJ+B5OgOFkXe2fBzCrTtBvASHj3bmLAC1pf/130OY5NAjbc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301909; c=relaxed/simple;
	bh=u48Bu1/vukr8Av3MozjIZz2iPuqKWdqXErQNs/M2D4I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kKnObDmI1tW7vovz/bhKEWEQGYU68PgYzBeKnka2AxMTlPcIxOgxEGqTyUdTeM9euMHhWO/GOFsT+YYPLRhZqmwBIhM/9pSImWfc/6x0qb31ZG/nfA5/+xUT6Bso9If+c3YB5W/uoEzWmMqTc5t81zmKNtl95lE/haUE15ketck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIAUuZnw; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e728841ed96so3159030276.3
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 23:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745301905; x=1745906705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKkk3d/A2hY5SZEPBAt7IvK3nklmkkyQkjoXWutUd30=;
        b=BIAUuZnwMiQOxv+fHg8DQgS+IdU7Afay7dVSjAOvvZFV8qM4qc/e2za0J+/tYNYM6r
         vq+cdIO1k6pgUiq871bKlooKBqM31xKhnSEB15n+TNdLWkGpxRRGMburCJaXsq8WTXcR
         2q4xxCTKBaUxB28XBbADLLZnS5u7Bf09Jlk3ZZZujuEqEh1nMdwZIVLB4k3x1LP21FcH
         VptCqVvJPYXfzm7oAPNzPg4//59SrGgWisaQ0CiBwXuhXnvNVPr/cAhheTXI8BOCJMPl
         3O6qTJy3UPpn0xlhgyPnioqYZzJoJt9gE3VswWgT9EYnahyShX5cqCLen/ANIuap48nL
         Allw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745301905; x=1745906705;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKkk3d/A2hY5SZEPBAt7IvK3nklmkkyQkjoXWutUd30=;
        b=Zx12fIaSKU5W/DaOyyilNJAwwyqAyYFhAePgs/UCcjE0ooHfGm1S8gZ9ucqeuDFMwH
         /2x8cRffkKhcsCT6XwxO51rpIgQ2MWjQN6ADf2/AYc703TVq/Y5FSzLJq9owMt0XWFVR
         4q+gpSnhBQ/JtDNDVPW+LFKAbwsM5A+pls+6Yl/rFj3KT7WJQDk0vdSMngAUrLlm07sL
         GpvTIPpX1fwl8XD64D7Jfip1VbQAlxaK955WUZAl0B2UALtJIcgQsRMgW2HDjC3Qnl23
         ES9SQPWoBy3i42eYkJnAgPXqk12VoOp+B+2FsjeHjxMKvC7pPw/aJCeDhIX1h44F98/g
         QV2g==
X-Gm-Message-State: AOJu0YxTr7nAQsb8TCE+w8jnDA4pDBJZYaQNoD3McUxI9Upa5/lhxVlJ
	2sAzak05nqg7sdU+ciq43ZJ7qO3owGGrhNeOuAfrPGMSOpD0CjzAFeielNRWQuF8daMt6bCU0Tn
	3rVxWqLKZAVeDF8GVgnhzbCD192s=
X-Gm-Gg: ASbGncviKITTvC37cPx0tWtZ1gIpmcYgd/C1XNC1EGJ6+a1Pjp5AQyNL0EsNTDx7Dlg
	NC6HFMq4x/Mh2fgh7Pb4MAT7o64b5HzFcuVj3t907RyzF7y1eqiah27Zsn5NSQPG/0iWreXUt0N
	dkM0DOXFhwle50pp/HpCKX8KXWHyq39j1CXjbMVg==
X-Google-Smtp-Source: AGHT+IElHopa890PfT6wXdjvHWR7e40JpMJD0t3Prni4qOufHNDadZcTJiM0ANKH/1NZmgLJ5+QaGO/eARzED6sYfNE=
X-Received: by 2002:a05:6902:f85:b0:e5e:1389:cb40 with SMTP id
 3f1490d57ef6-e7297dc91d5mr19597681276.13.1745301905381; Mon, 21 Apr 2025
 23:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 22 Apr 2025 14:04:45 +0800
X-Gm-Features: ATxdqUFtOCm1BFDk3RlnUUcLKZIsJJCf2w2jvnscRxyGHfWUIgNv9hfDpU9TWKY
Message-ID: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>
Subject: Please apply d2155fe54ddb to 5.10 and 5.4
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg and Sasha,

Please consider applying d2155fe54ddb ("mm: compaction: remove
duplicate !list_empty(&sublist) check") to 5.10 and 5.4, as it
resolves a -Wdangling-pointer warning in recent GCC versions:

In function '__list_cut_position',
    inlined from 'list_cut_position' at ./include/linux/list.h:400:3,
    inlined from 'move_freelist_tail' at mm/compaction.c:1241:3:
./include/linux/list.h:370:21: warning: storing the address of local
variable 'sublist' in '*&freepage_6(D)->D.15621.D.15566.lru.next'
[-Wdangling-pointer=]

Regards,
Qingfang

