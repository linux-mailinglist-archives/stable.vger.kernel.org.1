Return-Path: <stable+bounces-124272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C76FA5F259
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F69C17D503
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7CA1F151E;
	Thu, 13 Mar 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U8l72FYJ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CE26462C;
	Thu, 13 Mar 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865408; cv=none; b=Gi7jWJJ2Vywh1OQFlzMm/e+DfDbRKm0yqrr0t3tQQjfgEjH5B8SKOfRSn8Y6hTi9UHlMz594CbacxLCnIdypt9uaJrJ1oNycTaTVZlFah25ioiNfutr/Z+CJY3jYt2c1f7y39GGkWU1zf5+G/hUfBQtTsez9z5bx6HNRrWrNpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865408; c=relaxed/simple;
	bh=W7dCLv2LIxVb5EPgu8K+rcWCtWITSRDcEX4nfylHlzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoD0q6bBsBmH7Xd7qCmZwQPO/NQIIX1CzVeCoZg+wXb9nA0Xi9i6L0dSvG8/GLjLpma6yAcMR4uDQbxQc3azyBODi63PgJlZ1v0Vm+/YbZxymoFYmz0ffjPBZeSlokAKaf6stTm5bIHeWde/1oh55tq4zOaXsBYN/v+IC+XsFw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U8l72FYJ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Pm73EJRQgZ77/ckvxKpjTwQ+FlBGwLcf98qwKNe6V94=; b=U8l72FYJdvxrrI/bNfTq5ItQR4
	KKq4RgfZ17RBeMUI0YllEwMBqPOKrG4DDY7eYaUekOjC4LtFFS1MOjEJshIFCToLUqOtJLtOy3FZp
	okLNEOcETz9+Uob8y0ojphdOXxCLZLUf9cAl/kqSQqvy9PDIv2yK+q4JoM899xdtAAAeC84e0ibry
	isFYZ1sX2o/b1W3FXhWXvVXOYooB/SIPNJnTdhNNdwynB4aQoJvFs8voDI3zELohMHHuzPs90YeoF
	JWYoe5MYJVz+84QLCho5HnPqe2zi6851ZJqP3ap7QgUNNdHz7yjGEVR2MFg7ShoNneBOyoh2WUQK2
	9MNUNE5w==;
Received: from 179-125-64-252-dinamico.pombonet.net.br ([179.125.64.252] helo=quatroqueijos)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tsgl6-0084nJ-Qr; Thu, 13 Mar 2025 12:29:59 +0100
Date: Thu, 13 Mar 2025 08:29:59 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tom Chung <chiahsuan.chung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	stable@vger.kernel.org, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: Re: [PATCH] drm/amd/display: avoid NPD when ASIC does not support
 DMUB
Message-ID: <Z9LBt2ePtxJ0Nzz4@quatroqueijos>
References: <20250205-amdgpu-dmub-v1-1-88151fe565d8@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205-amdgpu-dmub-v1-1-88151fe565d8@igalia.com>

On Wed, Feb 05, 2025 at 10:06:38AM -0300, Thadeu Lima de Souza Cascardo wrote:
> ctx->dmub_srv will de NULL if the ASIC does not support DMUB, which is
> tested in dm_dmub_sw_init.
> 
> However, it will be dereferenced in dmub_hw_lock_mgr_cmd if
> should_use_dmub_lock returns true.
> 
> This has been the case since dmub support has been added for PSR1.

This bug has landed on stable trees. Any chance for a review here?

Thanks.
Cascardo.

> 
> Fix this by checking for dmub_srv in should_use_dmub_lock.
> 
> [   37.440832] BUG: kernel NULL pointer dereference, address: 0000000000000058
> [   37.447808] #PF: supervisor read access in kernel mode
> [   37.452959] #PF: error_code(0x0000) - not-present page
> [   37.458112] PGD 0 P4D 0
> [   37.460662] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   37.465553] CPU: 2 UID: 1000 PID: 1745 Comm: DrmThread Not tainted 6.14.0-rc1-00003-gd62e938120f0 #23 99720e1cb1e0fc4773b8513150932a07de3c6e88
> [   37.478324] Hardware name: Google Morphius/Morphius, BIOS Google_Morphius.13434.858.0 10/26/2023
> [   37.487103] RIP: 0010:dmub_hw_lock_mgr_cmd+0x77/0xb0
> [   37.492074] Code: 44 24 0e 00 00 00 00 48 c7 04 24 45 00 00 0c 40 88 74 24 0d 0f b6 02 88 44 24 0c 8b 01 89 44 24 08 85 f6 75 05 c6 44 24 0e 01 <48> 8b 7f 58 48 89 e6 ba 01 00 00 00 e8 08 3c 2a 00 65 48 8b 04 5
> [   37.510822] RSP: 0018:ffff969442853300 EFLAGS: 00010202
> [   37.516052] RAX: 0000000000000000 RBX: ffff92db03000000 RCX: ffff969442853358
> [   37.523185] RDX: ffff969442853368 RSI: 0000000000000001 RDI: 0000000000000000
> [   37.530322] RBP: 0000000000000001 R08: 00000000000004a7 R09: 00000000000004a5
> [   37.537453] R10: 0000000000000476 R11: 0000000000000062 R12: ffff92db0ade8000
> [   37.544589] R13: ffff92da01180ae0 R14: ffff92da011802a8 R15: ffff92db03000000
> [   37.551725] FS:  0000784a9cdfc6c0(0000) GS:ffff92db2af00000(0000) knlGS:0000000000000000
> [   37.559814] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.565562] CR2: 0000000000000058 CR3: 0000000112b1c000 CR4: 00000000003506f0
> [   37.572697] Call Trace:
> [   37.575152]  <TASK>
> [   37.577258]  ? __die_body+0x66/0xb0
> [   37.580756]  ? page_fault_oops+0x3e7/0x4a0
> [   37.584861]  ? exc_page_fault+0x3e/0xe0
> [   37.588706]  ? exc_page_fault+0x5c/0xe0
> [   37.592550]  ? asm_exc_page_fault+0x22/0x30
> [   37.596742]  ? dmub_hw_lock_mgr_cmd+0x77/0xb0
> [   37.601107]  dcn10_cursor_lock+0x1e1/0x240
> [   37.605211]  program_cursor_attributes+0x81/0x190
> [   37.609923]  commit_planes_for_stream+0x998/0x1ef0
> [   37.614722]  update_planes_and_stream_v2+0x41e/0x5c0
> [   37.619703]  dc_update_planes_and_stream+0x78/0x140
> [   37.624588]  amdgpu_dm_atomic_commit_tail+0x4362/0x49f0
> [   37.629832]  ? srso_return_thunk+0x5/0x5f
> [   37.633847]  ? mark_held_locks+0x6d/0xd0
> [   37.637774]  ? _raw_spin_unlock_irq+0x24/0x50
> [   37.642135]  ? srso_return_thunk+0x5/0x5f
> [   37.646148]  ? lockdep_hardirqs_on+0x95/0x150
> [   37.650510]  ? srso_return_thunk+0x5/0x5f
> [   37.654522]  ? _raw_spin_unlock_irq+0x2f/0x50
> [   37.658883]  ? srso_return_thunk+0x5/0x5f
> [   37.662897]  ? wait_for_common+0x186/0x1c0
> [   37.666998]  ? srso_return_thunk+0x5/0x5f
> [   37.671009]  ? drm_crtc_next_vblank_start+0xc3/0x170
> [   37.675983]  commit_tail+0xf5/0x1c0
> [   37.679478]  drm_atomic_helper_commit+0x2a2/0x2b0
> [   37.684186]  drm_atomic_commit+0xd6/0x100
> [   37.688199]  ? __cfi___drm_printfn_info+0x10/0x10
> [   37.692911]  drm_atomic_helper_update_plane+0xe5/0x130
> [   37.698054]  drm_mode_cursor_common+0x501/0x670
> [   37.702600]  ? __cfi_drm_mode_cursor_ioctl+0x10/0x10
> [   37.707572]  drm_mode_cursor_ioctl+0x48/0x70
> [   37.711851]  drm_ioctl_kernel+0xf2/0x150
> [   37.715781]  drm_ioctl+0x363/0x590
> [   37.719189]  ? __cfi_drm_mode_cursor_ioctl+0x10/0x10
> [   37.724165]  amdgpu_drm_ioctl+0x41/0x80
> [   37.728013]  __se_sys_ioctl+0x7f/0xd0
> [   37.731685]  do_syscall_64+0x87/0x100
> [   37.735355]  ? vma_end_read+0x12/0xe0
> [   37.739024]  ? srso_return_thunk+0x5/0x5f
> [   37.743041]  ? find_held_lock+0x47/0xf0
> [   37.746884]  ? vma_end_read+0x12/0xe0
> [   37.750552]  ? srso_return_thunk+0x5/0x5f
> [   37.754565]  ? lock_release+0x1c4/0x2e0
> [   37.758406]  ? vma_end_read+0x12/0xe0
> [   37.762079]  ? exc_page_fault+0x84/0xe0
> [   37.765921]  ? srso_return_thunk+0x5/0x5f
> [   37.769938]  ? lockdep_hardirqs_on+0x95/0x150
> [   37.774303]  ? srso_return_thunk+0x5/0x5f
> [   37.778317]  ? exc_page_fault+0x84/0xe0
> [   37.782163]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [   37.787218] RIP: 0033:0x784aa5ec3059
> [   37.790803] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1d 48 8b 45 c8 64 48 2b 04 25 28 00 0
> [   37.809553] RSP: 002b:0000784a9cdf90e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   37.817121] RAX: ffffffffffffffda RBX: 0000784a9cdf917c RCX: 0000784aa5ec3059
> [   37.824256] RDX: 0000784a9cdf917c RSI: 00000000c01c64a3 RDI: 0000000000000020
> [   37.831391] RBP: 0000784a9cdf9130 R08: 0000000000000100 R09: 0000000000ff0000
> [   37.838525] R10: 0000000000000000 R11: 0000000000000246 R12: 0000025c01606ed0
> [   37.845657] R13: 0000025c00030200 R14: 00000000c01c64a3 R15: 0000000000000020
> [   37.852799]  </TASK>
> [   37.854992] Modules linked in:
> [   37.864546] gsmi: Log Shutdown Reason 0x03
> [   37.868656] CR2: 0000000000000058
> [   37.871979] ---[ end trace 0000000000000000 ]---
> [   37.880976] RIP: 0010:dmub_hw_lock_mgr_cmd+0x77/0xb0
> [   37.885954] Code: 44 24 0e 00 00 00 00 48 c7 04 24 45 00 00 0c 40 88 74 24 0d 0f b6 02 88 44 24 0c 8b 01 89 44 24 08 85 f6 75 05 c6 44 24 0e 01 <48> 8b 7f 58 48 89 e6 ba 01 00 00 00 e8 08 3c 2a 00 65 48 8b 04 5
> [   37.904703] RSP: 0018:ffff969442853300 EFLAGS: 00010202
> [   37.909933] RAX: 0000000000000000 RBX: ffff92db03000000 RCX: ffff969442853358
> [   37.917068] RDX: ffff969442853368 RSI: 0000000000000001 RDI: 0000000000000000
> [   37.924201] RBP: 0000000000000001 R08: 00000000000004a7 R09: 00000000000004a5
> [   37.931336] R10: 0000000000000476 R11: 0000000000000062 R12: ffff92db0ade8000
> [   37.938469] R13: ffff92da01180ae0 R14: ffff92da011802a8 R15: ffff92db03000000
> [   37.945602] FS:  0000784a9cdfc6c0(0000) GS:ffff92db2af00000(0000) knlGS:0000000000000000
> [   37.953689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.959435] CR2: 0000000000000058 CR3: 0000000112b1c000 CR4: 00000000003506f0
> [   37.966570] Kernel panic - not syncing: Fatal exception
> [   37.971901] Kernel Offset: 0x30200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   37.982840] gsmi: Log Shutdown Reason 0x02
> 
> Fixes: b5c764d6ed55 ("drm/amd/display: Use HW lock mgr for PSR1")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Cc: stable@vger.kernel.org
> Cc: Sun peng Li <sunpeng.li@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> index 5bb8b78bf250a0e56c3e99ce7c99ed7f70c8f0f6..eef817a4c580aca2ebc7fb1b77cfc0377d477bdc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> @@ -63,6 +63,9 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
>  
>  bool should_use_dmub_lock(struct dc_link *link)
>  {
> +	/* ASIC doesn't support DMUB */
> +	if (!link->ctx->dmub_srv)
> +		return false;
>  	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 ||
>  	    link->psr_settings.psr_version == DC_PSR_VERSION_1)
>  		return true;
> 
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250205-amdgpu-dmub-3fc25a0bc68e
> 
> Best regards,
> -- 
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 

