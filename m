Return-Path: <stable+bounces-93483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E87CA9CDA8E
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819ACB23FE5
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DC0189F30;
	Fri, 15 Nov 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aMT5PrLh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA62189F56
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659570; cv=none; b=djVaGlpaXacAiIbu01BF9+Togq+zSrfpJLod9KApfpDuNoyFlGOF3VN2B2PpiDb+hKtJhNFYYpqKfxV3RFxuuaCl5r0nW/0Hqb29wVnCjnNdV7Benod/GW0Oe/49h0a3iKCcY8xcmv57MSklN8dAJamzgbNG0nI9ZZcI7d4h4tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659570; c=relaxed/simple;
	bh=bwKXMZ/CqyKVXHRWjad7VNJ99PRPhanXO2k0v/9eehs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ocFthOY2tBHzCt5LmQeUamIAi/BWhChB0xGbxfRy4ZbN7ojhGfNybg0awDJhf6UHMBQmL2ygolqno8Z4oB4e/mbHP0RxUNM3JMez3Ppf0+/NfojkEmDEkM7gOCqNbVphnaznVJ9M5y4h6D3jtbtUS+g7LkCrwR9m52ENonUHNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aMT5PrLh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4609d8874b1so3448871cf.3
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731659568; x=1732264368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+oyM45fO7kqXMoRRUsCsV2dgNjzQvpxBqm/zmpiRHXg=;
        b=aMT5PrLhU3/rEXKmV8b/gSTcaPaEBIqL/sC7QJy4I/owxqJI6g2aFucI0+5aO/q+8F
         /6BiOXdjZgKlzKLkIauNMtN6XOrHWNYnPkoriKXfeg65hek4Z3XqZHawfuc/b7jS3znk
         5ToqosKOgc6xgJDRF7DpbnlsmiG70a0QXzLiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731659568; x=1732264368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oyM45fO7kqXMoRRUsCsV2dgNjzQvpxBqm/zmpiRHXg=;
        b=O51hgcY8OyK+wXl7KZjpHnCou+cv64SzoRkeQNdhQOY7UNnyEVjjGQOPxrAIk9+mDT
         y047e5QodE9WEeBK2ZOnLpe92hJdPb7EA9ceyOj66+qTy9xjhoAzhDZ3bfm6IQxr7EX3
         7IZHV+0HR2/9usPTPtlZ3zT1Tf2a8zReTZfNWL2B+qYB5wTdGaeoY9gtTG4pNPQ3TkIr
         vxDuXQQsn+CvvWZH/h4yiB5BQzPTXxNls354n59NqkBHhT39u/4djw84HLsGmFVo5HrZ
         rIXqQcjAZHwAbsvUZ7KQZx83s/lIWqf7kDoO47IJpFie6tF1eXsVShVCFCAqDou+/6ME
         nfTw==
X-Gm-Message-State: AOJu0YyAi2TACDSWFqF9qJeSLG5Bqh+Ml/sXuDwYfunKLg7av6yMtS3y
	KwdJYhPq+nva81mx9T1OV1yaVlEHKn4cfAsvyukRskhQKgDyjAonh/xHfTW1mkN4b5Cs2pwo9eW
	2uAS1Hfjrj6LoeMpW7WQ7VbUzhkZ92u3gKpJi7kLyGixlQl5TKPzRA2i6FwyJKoy9IpoQ/v6rkY
	0oDBVLlhizrL/w7nqjVB8+2XE93hO+20327S35z36Rk8hOvvKYurU/DpEt2Dzl0MQ=
X-Google-Smtp-Source: AGHT+IEIC73NXLt7bHwh/TMQ6UkI0zrz/RHhFfkxb8RIMOzTdzyOAiIAIfCgAfuhcrXgqjJXvnY2dQ==
X-Received: by 2002:a05:622a:5187:b0:460:9ac7:8fcd with SMTP id d75a77b69052e-46363de864bmr26095761cf.1.1731659567548;
        Fri, 15 Nov 2024 00:32:47 -0800 (PST)
Received: from vb004028-vm1.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635aa37c54sm16584231cf.53.2024.11.15.00.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:32:47 -0800 (PST)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: yuxuanzhe@outlook.com,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	sashal@kernel.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v6.1 0/2] ksmbd: fix potencial out-of-bounds when buffer offset is invalid
Date: Fri, 15 Nov 2024 08:32:38 +0000
Message-Id: <20241115083240.230361-1-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dependent patch (slab-out-of-bounds) is backported from 6.7 instead of 6.6.
In the 6.6 commit (9e4937cbc150f), the upstream commit id points to an incorrect one.

Namjae Jeon (2):
  ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()
  ksmbd: fix potencial out-of-bounds when buffer offset is invalid

 fs/smb/server/smb2misc.c | 26 ++++++++++++++++------
 fs/smb/server/smb2pdu.c  | 48 ++++++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 29 deletions(-)

-- 
2.39.4


