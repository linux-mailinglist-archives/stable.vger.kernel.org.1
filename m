Return-Path: <stable+bounces-194644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB31C54862
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 21:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3C90346FF0
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 20:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF42D979F;
	Wed, 12 Nov 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nENnTOM6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB32D8799
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981056; cv=none; b=PWxNGA/SHOf/pxYx1snQpfVCZVYfp5wBbtRoawx1u7/WMR4BwP584z2HpoSslIlFBqjCX1R2b5y73trRZpH/Xp/LTkf8aKsj43bY+2EfsNMdtTGF3v7a+WoFuks1B5vU/ETh8tGZ/YXZGHgLDWevaD+hQVz6AMEnb03qZ22KHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981056; c=relaxed/simple;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8rU5wXridQBarVFoKWtnac1NFA37x9TYUHpyIAyqzbv864gFGEja8cpkRJ3pLsyVjoMDzfQqPvIWuOgnwguMoXD16VZeLL80WwviR3dhSdpdofgNLX8GdtEX5dXwlb2p/+Gwnv7iBL6MbPk56PDD+sKiKH4wlxTaN1sR+TQkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nENnTOM6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so58912b3a.0
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 12:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981052; x=1763585852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=nENnTOM6o32CIi43t6mmtTH13aEmNAMkE650Gsvba6qUiRYzOwE3Z6hFTOGsm/9ods
         +Fdgzt9TirnZZsMCW79LPpXnI2WAJQUrVtERchb1RFXgxP0hmAcaZIMP7u8oSTDJxTC/
         64QaHmH9Gnl37DECTsUHAIGIzwrvICLb4A5hufoW0VmDcwlT8/TUYcFDkeYCRFm8KK04
         iSMkuaNhPtPl82xgh5Y8IlEeS5/yFpQ8QK2RoxImOPVKhMQxTBfYMxGNOyj7cECdSaO4
         nuZEz/4tVtr2ZfIs2D3XBq4LPtjFsE9nU8N4pZxy+zPcqdQILb9Fj5iYa3B6W1upxG4e
         MZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981052; x=1763585852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=RkkPN5eCMHpkWhoG+4YgKYP26I6xpW41e+Zx2XBy7c+j6hWBzus9RpXixMUKRBqWSM
         zQ3V65o+K4FmXMZtaiz1Q8rPDDUUXdaadCiW39uJd9CT63Gp9Glh1txLQsKoipd0Oegi
         DDsJma+kU1yI5VM03pf5VGKjfkiReJdSFFX3BVhnwac1mhYvBjVM+fyHf+JhY1ojIN7V
         su2YYswLVLoh8CzvrW0otZI0UJOaJHQK7EqJpl1wE9gYw3yQnUvW1huaeNcwVPqaJWhA
         MSyWcyHeWFC4aBqiZ+O76FE/mQ+v8bGX7OWQhnoqViZcGqFS9qdgCGWS8ttL4HMG6dJr
         TKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXghfT4zFaOS+VM+slEaPE0eWSVVeo8IZAcUcSXhl/GLlSkoJQCBoRhjNGUdbwWFm5/a1xcn/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xnYM0UqwQLbB9kC/Mhku+unLclc+cCme2sgFE7ZbFyBQy+mQ
	/MUaG7aSZA69mWIu8b+O2jsmxfhVoFwKN3nGtsuH6YeWogZYUuMjuTxn
X-Gm-Gg: ASbGncvUFpvkGoC3ENAxIjzwTYh08sscp1mm5YxQvaPrFKtVbMZhSa5P09wlAvAyDlf
	Veqq328pVbg5Okyp1Wsy1Ua9nJHrT7oWwh6Lz5DRfSaiAMqUQXgImBxXx/g0JXs0e4lunGa3Jck
	oztioQhGv2DNEctlLLj9zARaGHE3RdN89gvu4hzv0qnS9dP14XnjvUsdSJbat9WzOZC1wJpce2K
	b1uBsCi88BSJMki3C2UIMwiiaui7ieobwg1xNUmjc2RJqRlCJWwwB76MBv+4iy3fqEWv6A7WMvR
	jrKicprWPsc07IgAKBFpfVbClFhihCpxRZOfAofZPmpN8hMID3pxA+MtLpLLuFs2hqMysu4ipr1
	/0PEcA7rsNT9kQXXqdo+Av6KzHcs1IQenoy0IOt0OLRU4VaBK8GnMlXSlRjTPp+ep+S5hY7MD9E
	yksXeGQi7BlQTjyja7
X-Google-Smtp-Source: AGHT+IGdMtp+09DXVYWSKyjJdioZZesgS/AZ7o755mfw+un+OTDPSYca4Rd680rwoglcSj+HIufhdw==
X-Received: by 2002:a05:6a20:7f9a:b0:344:a607:5548 with SMTP id adf61e73a8af0-3590be1055emr5921739637.58.1762981052263;
        Wed, 12 Nov 2025 12:57:32 -0800 (PST)
Received: from [10.230.2.0] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc3781866efsm4381a12.37.2025.11.12.12.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:57:31 -0800 (PST)
Message-ID: <532a289f-f10b-4d3b-9dfd-d5c5a5381dde@gmail.com>
Date: Wed, 12 Nov 2025 12:57:00 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: nvme-fc: Ensure ->ioerr_work is cancelled in
 nvme_fc_delete_ctrl()
To: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Cc: mpatalan@redhat.com, james.smart@broadcom.com, paul.ely@broadcom.com,
 justin.tee@broadcom.com, sagi@grimberg.me, njavali@marvell.com,
 ming.lei@redhat.com, stable@vger.kernel.org
References: <20251110212001.6318-1-emilne@redhat.com>
 <20251110212001.6318-3-emilne@redhat.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20251110212001.6318-3-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

