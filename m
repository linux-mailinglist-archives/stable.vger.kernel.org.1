Return-Path: <stable+bounces-67341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10B94F4F9
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8E9B26D68
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528F186E33;
	Mon, 12 Aug 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+kflAhn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350FD15C127;
	Mon, 12 Aug 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480610; cv=none; b=kyBZ87SLvg4rzIf7EKF1UlGgmCW/gxQiN165uFHe90UmlOY6HDdyzVxkOFch6fFOY7en+Khbm3MAKDSN+sRXM4+ViXbSBJ/u7I8EqSTwBMkl8wvyx26MQyXMtSu7QesVqHBD++bSQnlDVRVVJvKkN8JL+9aBkfGWIZ7yHSQOTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480610; c=relaxed/simple;
	bh=ZNuUfSDfBV1LsV5gv+rGwPWPTZsGMHpR+PT+c7DKeHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sz5lg6zfpLZjOGMwNXe5Y0uks+jljOhV6kpU2mQH6T0SnlWje4K9of7KPdLY+y96qjlkW6nAnagSq9x8/fIjb/YnsehMx9Al69EU6TzxmRiaXKOa/por2fwbKGsbdXuzEn0YMUdRGDqPdi4M20rJQtG7jxoiiiDZ1jFcrf3F5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+kflAhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1165C4AF09;
	Mon, 12 Aug 2024 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480610;
	bh=ZNuUfSDfBV1LsV5gv+rGwPWPTZsGMHpR+PT+c7DKeHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+kflAhnIN/r8m7kKoBEAczSRqt7fDhGYnTPuac4noNmT5jpilXAQIG8BFsdi/eFq
	 mYMnekiFmHUs6tZBzfwL1J3xXcxxDf6hdf0WBqp+vo+gEnKQFot1hS7xDmgrPTNxle
	 0rljLqzr3HymBdd8qLVp5+CvDbGeTxu1YVfSbp3c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.10 247/263] drm/radeon: Remove __counted_by from StateArray.states[]
Date: Mon, 12 Aug 2024 18:04:08 +0200
Message-ID: <20240812160156.000769152@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bill Wendling <morbo@google.com>

commit 2bac084468847cfe5bbc7166082b2a208514bb1c upstream.

Work for __counted_by on generic pointers in structures (not just
flexible array members) has started landing in Clang 19 (current tip of
tree). During the development of this feature, a restriction was added
to __counted_by to prevent the flexible array member's element type from
including a flexible array member itself such as:

  struct foo {
    int count;
    char buf[];
  };

  struct bar {
    int count;
    struct foo data[] __counted_by(count);
  };

because the size of data cannot be calculated with the standard array
size formula:

  sizeof(struct foo) * count

This restriction was downgraded to a warning but due to CONFIG_WERROR,
it can still break the build. The application of __counted_by on the
states member of 'struct _StateArray' triggers this restriction,
resulting in:

  drivers/gpu/drm/radeon/pptable.h:442:5: error: 'counted_by' should not be applied to an array with element of unknown size because 'ATOM_PPLIB_STATE_V2' (aka 'struct _ATOM_PPLIB_STATE_V2') is a struct type with a flexible array member. This will be an error in a future compiler version [-Werror,-Wbounds-safety-counted-by-elt-type-unknown-size]
    442 |     ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1 error generated.

Remove this use of __counted_by to fix the warning/error. However,
rather than remove it altogether, leave it commented, as it may be
possible to support this in future compiler releases.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2028
Fixes: efade6fe50e7 ("drm/radeon: silence UBSAN warning (v3)")
Signed-off-by: Bill Wendling <morbo@google.com>
Co-developed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/pptable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/pptable.h
+++ b/drivers/gpu/drm/radeon/pptable.h
@@ -439,7 +439,7 @@ typedef struct _StateArray{
     //how many states we have 
     UCHAR ucNumEntries;
     
-    ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
+    ATOM_PPLIB_STATE_V2 states[] /* __counted_by(ucNumEntries) */;
 }StateArray;
 
 



