Return-Path: <stable+bounces-60731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B7F939B68
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 09:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3FB282A8F
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 07:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A714A4DA;
	Tue, 23 Jul 2024 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aKsC2dVQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8E13D882
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718397; cv=none; b=dgSiaCsPCEnlOAjot5mnSJBhfL7C7oBH8rIk+8zZ+uyZpgxZuh+pYAuNVgrD+wqwYAXN8B5nJdAvOiFJAK7JlMDgeFscuC28Wu8XN2nrDHX6nMWgMWwmbC+ZsPsD1GJlTbAHY47HwqNfGRMIiqH966nb9VOGzwgbcBjCUSzoVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718397; c=relaxed/simple;
	bh=T0a5WQAwYpflbA1vg5hpjmRavw1oEVX/Ht39sOULNIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nncLm/SCifm6O3duZNKoqOHdnZ2NBwSCrUSUgLDgM17gcC55HkKdonVLuPRqjVQ3/Ax9ZoUS+lTlpr+3iWUHt/LHQIORB5UKZnzfVC+8DiATbYsvr55SQ8aANsZQzcOrSYCCnVi/Kn9eM7ZC6HJrbNHyqGL7F8bNyc0kGBNE6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aKsC2dVQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d1dadd5e9so1406156b3a.2
        for <stable@vger.kernel.org>; Tue, 23 Jul 2024 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721718395; x=1722323195; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TVQolDblYpfBAHM0BVYvZ7L0Xvl6DY3RRTkKfePEOus=;
        b=aKsC2dVQE/IB/Iv0FYumrRLGzIUHEyEZ7IsmMVY7f63qfFgTZX6upBtEhKeGNzmFP9
         mS+UvFRbJH9AOni/pmG0mM8UjHKb2yBkUuZJ8dpqEUAlvBYm0BLl5yjcS+jSD7+yw+Zu
         F4AMS7Hm6JNTCaAX3TTqI2/7boHQsmf6E57WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721718395; x=1722323195;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVQolDblYpfBAHM0BVYvZ7L0Xvl6DY3RRTkKfePEOus=;
        b=D/WMNAHvK7e7SxFbxXLGw6tB7PObvzb0pU5KDpc8b8pwUYJ4XYX/OII2VsBHUDRnnq
         zc2ea6MjsxLKA/jmuByRb4+hOJ3zSTfrkRpVmwEavreVhfgu5Nv6srLDVMgAlj4exTdL
         wVbj+66Ft73gOakQda/c2mt35RPLXarpT7ZPOvS/Ms8qI3xIxg2X4whRMPO0vFDVPUlP
         y+I2Q/W1Cu6W5CD42JAXqBga9uZjo4dioSt2gKDkX5fLI0YNpz7bIdBul4T0DmBERiMG
         W06zBMCILWEcgY5uIS2BN1HJo8x/FFYIQqfXQZ2pvLF8z4mvmxxaOWWklPx+Vi+HbQbv
         bFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYimr7qCci5RVQqRTdkjSvua85V9d1sxybuTq3a8/qvy4H9h3hQ2wRIL8QJjfYS7PoDJ+z5bWiB5c2MgC4w0hScN7bAGBs
X-Gm-Message-State: AOJu0YwD+XmgkrKelSgNOcnlsEsUj1/uWMSeV3Kevvm5Hm7tetYcBy4Y
	VL/Qb/kEBOYT6PUT94Hb6aiRAaCe8pyXS4SlTGv907FyQeOfgsJ+o5kTCHjdYQ==
X-Google-Smtp-Source: AGHT+IH6yBqLPZThrJF1lWBcvb2T28e1qgZqnd8sJbhHQ+K1obWAqxroFQqZT+6CS59cjnBEKk6+6w==
X-Received: by 2002:a05:6a21:9993:b0:1c2:8dd5:71d9 with SMTP id adf61e73a8af0-1c4285b75f1mr8005527637.4.1721718394067;
        Tue, 23 Jul 2024 00:06:34 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25ac64sm67166915ad.59.2024.07.23.00.06.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2024 00:06:33 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: gregkh@linuxfoundation.org
Cc: amir73il@gmail.com,
	chuck.lever@oracle.com,
	jack@suse.cz,
	krisman@collabora.com,
	patches@lists.linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com
Subject: [PATCH 5.10 387/770] fanotify: Allow users to request FAN_FS_ERROR events
Date: Tue, 23 Jul 2024 12:36:27 +0530
Message-Id: <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20240618123422.213844892@linuxfoundation.org>
References: <20240618123422.213844892@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

> [ Upstream commit 9709bd548f11a092d124698118013f66e1740f9b ]
> 
> Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> user space to request the monitoring of FAN_FS_ERROR events.
> 
> These events are limited to filesystem marks, so check it is the
> case in the syscall handler.

Greg,

Without 9709bd548f11 in v5.10.y skips LTP fanotify22 test case, as: 
fanotify22.c:312: TCONF: FAN_FS_ERROR not supported in kernel

With 9709bd548f11 in v5.10.220, LTP fanotify22 is failing because of
timeout as no notification. To fix need to merge following two upstream
commit to v5.10:

124e7c61deb27d758df5ec0521c36cf08d417f7a:
0001-ext4_fix_error_code_saved_on_super_block_during_file_system.patch
https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com/T/#mf76930487697d8c1383ed5d21678fe504e8e2305

9a089b21f79b47eed240d4da7ea0d049de7c9b4d:
0001-ext4_Send_notifications_on_error.patch
Link: https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com/T/#md1be98e0ecafe4f92d7b61c048e15bcf286cbd53 

-Ajay


