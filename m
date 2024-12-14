Return-Path: <stable+bounces-104187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA42C9F1E4D
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 12:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C865D162517
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFA018C924;
	Sat, 14 Dec 2024 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhrnH/pW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D2170A13;
	Sat, 14 Dec 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734176168; cv=none; b=ZqPjy7Bbm6TyHQPjmT1r7/lxGH+CWabt2T3yg3hKUiH7yTl1Mc8M3598eNgsdDicv+EfvuNgxHIGyhgw5gKNNIbLxglgoES4/zveyl8VKn78aNB4x+KednUNJnqmiZ+OBU+jL2lTS3ZvM5frXyXoqDfYM9HPRhtuwv9wH/qQRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734176168; c=relaxed/simple;
	bh=w3HeaF2v1sPGKZZGi3apRizueqVTdJOGs3yn14XsZds=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=diIgDHvXpsou1S6J5acOK99i8wmQkFntGp5+KRkGVO2NBtqh14h38kzCYzl9sVwJhlCY/rVYTEwnRU2J9+hBHC84clHNj0GQdPh9KM7wyi1T22IaphV6ccnhW+5O97wHBz3nJ8pYzYBXjV07bGyJ9vyF6ANAoz/6IZBxohAgjOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhrnH/pW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so2973180a91.0;
        Sat, 14 Dec 2024 03:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734176166; x=1734780966; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NgMsVx6LalBM3WCUrF4IRtnX3JNL264uu8F1CqpXfck=;
        b=KhrnH/pW+ANRzudwGub3diIRok/Kq7HyRtKBFpKA5p6FryHsZSlNE4RM9hq6//9saS
         QR5C9A4O3zNba79lyXBULrshYpVViaP63EmPbKK4rVqIM/fSVg4IuRe1y9RwtG8hZzyE
         q1D+kN5ECV3pYIw3V6yWSICtbG/ypLjQkS1NMx9/JtlrfgbyWL+LpGkptEUpHqw7x2EM
         2QhmZ7NeWF5Il5NVEhRcqtLT7Ig4Wy3wV4qq3vmXikKHHWLQlgfA1+WTAM9vrKey3dBn
         tjPIKc08k28nEFmChBgj3mKk6JpRHfNQCJyqchEoo2pew3dsOO1y+Tr2l0zAxARCyGs8
         LCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734176166; x=1734780966;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgMsVx6LalBM3WCUrF4IRtnX3JNL264uu8F1CqpXfck=;
        b=cvLO/Pxwjphp3nss7vYOyzcnT9x0M2zlZ/FItOU2658/ww5EsP7lrnlCaGts6q6EAS
         dkg1RjWxo4nHik2x1GEqGNiWzZXleLcLvO4cDm9whco7b/n3i2NqSQ+mhNDceGL5Wtro
         qniwUfWg/XLOmFke1Jz/jd17C1snZ7vyNGqrc5DKkUZyXFXibhQ7pUPJAwqmeWWN3juC
         XAUYr5Mh3i6UbQ1xK0ti2yNImagJZ0zmUaXNfG3ycmwkHf9j5TkrJNfKaettNtTGe50M
         D7dFct+lDNNHhHjPsCeGR8IzGZ+kZ1wGwvZ7uLwsrnXuejZjz8Oz08mNADgZNpRvO7ek
         1zNg==
X-Forwarded-Encrypted: i=1; AJvYcCWZSRYK46bXZi58yvdZEna3ZjkJXmu5j5WD4opFKBXLO0CZ9WlRt4DgR01EHpj9MPPQ2+KVjPJxBRbm2aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56bYDkFgbyrJ4kd1loT2AIqsRepBS6aQ2yawxlFtJK0C/NIbS
	nhjo7EneX7u0Iv5X5TrydW+hb08BgCczau+9rZ9lRC4c4w2uDBdt
X-Gm-Gg: ASbGncs7x7qbg5eqvI/Y/Jozvu+8QGpihWdiNW7G0rysdFLdDjsSorKcUEhT7gCeGN9
	W0bYa1PUBdCNJLlc7I/PBrfUpGh4aL2ILxkh8K4QIEgbM2TpXmyFcOmpsc0h9+ezlqJy7CtL+6N
	h5xW8qxiVsAekWAX4qqUuYdQWchIdTh5GS8DXQzrHws4d6Q7DDYbWniRsgQrtdTXd1h1bPMbCk2
	GicvzqaP6mjoA0DHsEIYDHWaL/jyOyEOKCOO0ONbH+R04ZGeA==
X-Google-Smtp-Source: AGHT+IHuxCFVFrk8Vz9sT5di4OuvtpoJ5KJwPjtYYcpOUcj42oCLFujWWI/ejP+u2tQbAW68orgrnA==
X-Received: by 2002:a17:90b:3912:b0:2ee:463d:8e8d with SMTP id 98e67ed59e1d1-2f13ac560dfmr16513874a91.14.1734176166073;
        Sat, 14 Dec 2024 03:36:06 -0800 (PST)
Received: from dw-tp ([171.76.83.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a1e9939fsm1266683a91.13.2024.12.14.03.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 03:36:05 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> 
To: Narayana Murty N <nnmlinux@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, maddy@linux.ibm.com, naveen@kernel.org, vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH v3] powerpc/pseries/eeh: Fix get PE state translation
In-Reply-To: <20241213091822.3641-1-nnmlinux@linux.ibm.com>
Date: Sat, 14 Dec 2024 16:58:12 +0530
Message-ID: <87v7vm8pwz.fsf@gmail.com>
References: <20241213091822.3641-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Narayana Murty N <nnmlinux@linux.ibm.com> writes:

> The PE Reset State "0" obtained from RTAS calls
> ibm_read_slot_reset_[state|state2] indicates that
> the Reset is deactivated and the PE is not in the MMIO
> Stopped or DMA Stopped state.
>
> With PE Reset State "0", the MMIO and DMA is allowed for
> the PE. The function pseries_eeh_get_state() is currently
> not indicating that to the caller because of  which the
> drivers are unable to resume the MMIO and DMA activity.
> The patch fixes that by reflecting what is actually allowed.
>
> Fixes: 00ba05a12b3c ("powerpc/pseries: Cleanup on pseries_eeh_get_state()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>
> ---
> Changelog:
> V1:https://lore.kernel.org/all/20241107042027.338065-1-nnmlinux@linux.ibm.com/

As discussed in v1, powernv already does this and this is needed for
pseries as well for the callers to know, whether the eeh recovery is
completed.

This looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

