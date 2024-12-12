Return-Path: <stable+bounces-102093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A7D9EF085
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09453189C806
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD823D42D;
	Thu, 12 Dec 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2pxOla4q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAA23D42A;
	Thu, 12 Dec 2024 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019945; cv=none; b=U46YpVoMiTZ8pL4efDWr837nD9j1EYDZpMNdd9oeU/CHzRdn8HjbL10xe/1XyYdm77q7w01z6WazNt99P9nSa6/A2/gUyOEU7DRK3SuXDDJNOjWJ759gYiX2oZIYAqkmIHrNWDIXjzlP4Y30pOUZFm+KuztCCgJQ5N1aM2oKKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019945; c=relaxed/simple;
	bh=Prt0H9FhRrJWa5kgV9LEcpPgkDb8A7Sq1HpqRhSTtXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU6Hcl945Qh6xFmkiUMIab6AUMe5grD6Et6bKWDLYK7K7T6/RNWJf59T9gi/DREyB1cPqrhgaRRihrjeyg24NeW6Of1WC1Y+tl/7HAcJP51l/4h3gq9QfQdjBvFViA17kpL700eVHAHpeybu8o76qb3mVrK1Dz3BnYhf+YYL0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2pxOla4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8B9C4CECE;
	Thu, 12 Dec 2024 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019944;
	bh=Prt0H9FhRrJWa5kgV9LEcpPgkDb8A7Sq1HpqRhSTtXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2pxOla4qIr/LzPwOGMvUO5bBQvQQMKycmDc84jIp7ONe0bbgffcw8F1+yhOJ93kq5
	 SEzyq0BAcKMlwIW+IUpQAhJsL5Jv1tvskDmw/6x8hWW58DPzM9y85O3nhgbqHqT8PB
	 CMiloebrBdpAnnw2KFyzqoGETeETqXo2PV2V1gJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Morris <rtm@csail.mit.edu>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6.1 338/772] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Thu, 12 Dec 2024 15:54:43 +0100
Message-ID: <20241212144403.873396480@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb upstream.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/record.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -273,7 +273,7 @@ struct ATTRIB *mi_enum_attr(struct mft_i
 		if (t16 > asize)
 			return NULL;
 
-		if (t16 + le32_to_cpu(attr->res.data_size) > asize)
+		if (le32_to_cpu(attr->res.data_size) > asize - t16)
 			return NULL;
 
 		if (attr->name_len &&



