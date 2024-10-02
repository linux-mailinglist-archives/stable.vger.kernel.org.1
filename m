Return-Path: <stable+bounces-78689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA9A98D473
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013BD2847C5
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6061CFEB0;
	Wed,  2 Oct 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="ZXppqSLf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249816F84F
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875234; cv=none; b=T62Yuxc1G33HbkxqL4zDJc3x/Mha4hXb+geGROAMzRXGUNH7wqmDeAsFOyALLm/1gFRJAcstBbbn1sJ6nczy8dNm7KvT5fOIvvPvLVPz6bxnM35N1G4tNKSckWM/oJgyeX3e/DOX61oxwxMklG9U0IO2zwtC+Zt5Rv6/tOpjoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875234; c=relaxed/simple;
	bh=HpCFfSlF9YE5HSc9XKyAXSEbEUm9yJI8sWGBo2kOkfo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eZBuVcH0kcOBk8SfRO7kFbu24ks6CjHu2jH8v5PyDkFxEqkvD01Nu1KTFy+sTD/4EUuzf51d7bSzh5QVhlrk5S/N4HnCZdJQdw7qNzDjGkTqTzrRahNsehUiqDeWJx1OUKc4FoSLsJtC0lLfArcbbQ73MN1JhkVDNkXJXkQwVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=ZXppqSLf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4582c4aa2c2so47626561cf.0
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1727875231; x=1728480031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HpCFfSlF9YE5HSc9XKyAXSEbEUm9yJI8sWGBo2kOkfo=;
        b=ZXppqSLfyXx62N0zL6uhjAh+39JNDzydZQyNFKAONIOrKw47bcPE30qbc/lhXw5SfJ
         ODJLq1uBYBwEySfXn7j/jkxKOREmjut5s2pw4V6CN/GmbHaJ/J9BWPcYud81psXVuBeq
         FLaGH7aJ003VrFWgUq6Su/MUTKxgiuYvjNXa8KaGJiPH1/YSa0oj9KhBhvXyBIQqJHN6
         gMlpxKqlfJfiP6s4dzFVxwWqtGKLqnE7cIlqygcz2jUpcEcAicXhws4r80RFLpVLWkH8
         Qf8sgpPH+P7WtDVi4R2rU4giv9UWGpPuP4Q1JRWovybpANqaapKT5RGcO4zpv2nYdnY/
         rs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875231; x=1728480031;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpCFfSlF9YE5HSc9XKyAXSEbEUm9yJI8sWGBo2kOkfo=;
        b=AovKi61Tkl42spAdxSsQyDZ6pKAweLZlm+WUTgUXx5s8SWXXPwgEOb4SfE4PJ/tJLY
         pQexyEql4b282v4Wuz4zYNPFGNrAETseKS0RO2GsG1tT6Y73UlxZ4wHSzFtTrwngA4JZ
         +EkJacXgCSUqs/xa7fnj1zi7WNS3Ki+b5Ez1ZmikuAj9wgnQ9TVVm/zSIK81W6zmWZ74
         ZO8efj3HubjhC5nDknxTIRDFCYqYD/TWP8ViRX+9dU6gksO2WmqHxTtKNqfGzouT/GpW
         mAh/AN3qgE5YevMw5PMvESDDc3j4PrVGZoNdy2pJXwxop/DRf4HFkgKT+rngdKdAeeZW
         I8Fw==
X-Gm-Message-State: AOJu0YwV0GGlHQ4nGhbinnWnq3YfL44NL4iTW3pfMRPv4jsCe3vkTHDj
	5YYj25gDviRS/UMGk03bE+4oAZjamKqHWKmh4ZlrBVmXzViUnxn42PPpoG53q+X6fi8IYm7Baw2
	v9vZoNa0mz1lUgQGkFXRYS8iC85Tt61vnX5ZvpYHMui66H+oUbf0=
X-Google-Smtp-Source: AGHT+IGgJBK/K5Z28QA31AqshDOS44O0Y/MWkehWHfzE0uUobuvlC7iwxgk4gHaberl033AyeWhWsn/k+KlMC3E832s=
X-Received: by 2002:ac8:5f8b:0:b0:458:3cc4:74fb with SMTP id
 d75a77b69052e-45d8053daf7mr40392101cf.37.1727875230858; Wed, 02 Oct 2024
 06:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maksym Kutsevol <max@kutsevol.com>
Date: Wed, 2 Oct 2024 09:20:20 -0400
Message-ID: <CAO6EAnX+qVoG=nLs7sONJsbUxzQu06yVJ3Mq5aqjp9p7ycji9w@mail.gmail.com>
Subject: Please include [PATCH net] netkit: Assign missing bpf_net_context
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Subject: [PATCH net] netkit: Assign missing bpf_net_context
commit id: 157f29152b61ca41809dd7ead29f5733adeced19
kernel versions: 6.11

The patch was sent before 6.11 was cut final, but it didn't make it.
We are seeing kernel crashes on 6.11.1 without this commit, with the
exact signature that the patch fixes.

Thank you.

Regards,
Maksym

